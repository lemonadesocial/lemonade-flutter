import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/lens/entities/lens_create_post.dart';
import 'package:app/core/domain/lens/entities/lens_create_post_metadata.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/lens/constants.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/graphql/lens/post/mutation/lens_create_post.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'dart:async';

import 'package:uuid/uuid.dart';

part 'create_lens_post_bloc.freezed.dart';

@freezed
class CreateLensPostEvent with _$CreateLensPostEvent {
  const factory CreateLensPostEvent.createPost({
    Input$ReferencingPostInput? quoteOf,
    Input$ReferencingPostInput? commentOn,
    required String content,
    String? lensFeedId,
    LensMediaImageMetadata? image,
    Event? event,
  }) = _CreatePost;
}

@freezed
sealed class CreateLensPostState with _$CreateLensPostState {
  const factory CreateLensPostState.initial() = CreateLensPostInitial;
  const factory CreateLensPostState.loading() = CreateLensPostLoading;
  const factory CreateLensPostState.success({
    required String txHash,
  }) = CreateLensPostSuccess;
  const factory CreateLensPostState.failed({
    required Failure failure,
  }) = CreateLensPostFailed;
}

class CreateLensPostBloc
    extends Bloc<CreateLensPostEvent, CreateLensPostState> {
  final LensRepository _lensRepository;
  final LensGroveService _lensGroveService;

  static final StreamController<bool> _createPostStreamController =
      StreamController<bool>.broadcast();

  static Stream<bool> get createPostResultStream =>
      _createPostStreamController.stream;

  CreateLensPostBloc(this._lensRepository, this._lensGroveService)
      : super(const CreateLensPostState.initial()) {
    on<_CreatePost>(_onCreatePost);
  }

  // ignore: library_private_types_in_public_api
  (String, LensCreatePostMetadata) prepareMetadata(_CreatePost blocEvent) {
    String schema = LensConstants
        .lensJsonSchemaByPostContent[Enum$MainContentFocus.TEXT_ONLY]!;
    LensCreatePostMetadata metadata = LensCreatePostMetadata.textOnly(
      id: const Uuid().v4(),
      content: blocEvent.content,
    );

    if (blocEvent.image != null) {
      schema = LensConstants
          .lensJsonSchemaByPostContent[Enum$MainContentFocus.IMAGE]!;
      metadata = LensCreatePostMetadata.image(
        id: const Uuid().v4(),
        content: blocEvent.content,
        image: blocEvent.image!,
      );
    }

    if (blocEvent.event != null) {
      schema = LensConstants
          .lensJsonSchemaByPostContent[Enum$MainContentFocus.EVENT]!;
      metadata = LensCreatePostMetadata.event(
        id: const Uuid().v4(),
        startsAt: blocEvent.event!.start?.toUtc() ?? DateTime.now().toUtc(),
        endsAt: blocEvent.event!.end?.toUtc() ?? DateTime.now().toUtc(),
        content: blocEvent.content,
        location: blocEvent.event!.virtualUrl?.isNotEmpty == true
            ? blocEvent.event!.virtualUrl!
            : blocEvent.event!.address?.title ?? 'Event address',
        links: blocEvent.event!.url != null ? [blocEvent.event!.url!] : null,
      );
    }

    return (schema, metadata);
  }

  Future<void> _onCreatePost(
    _CreatePost event,
    Emitter<CreateLensPostState> emit,
  ) async {
    try {
      emit(const CreateLensPostState.loading());

      final (schema, metadata) = prepareMetadata(event);

      final metadataJson = metadata.toJson();
      metadataJson.remove('runtimeType');

      Map<String, dynamic> uploadMetadata = {
        "\$schema": schema,
        "lens": metadataJson,
      };

      final uploadResult = await _lensGroveService.uploadJson(uploadMetadata);

      if (uploadResult == null) {
        throw Exception('Failed to upload metadata');
      }

      final request = Input$CreatePostRequest(
        contentUri: uploadResult['uri'] ?? '',
        quoteOf: event.quoteOf,
        commentOn: event.commentOn,
        feed: event.lensFeedId,
      );

      final result = await _lensRepository.createPost(
        input: Variables$Mutation$LensCreatePost(
          request: request,
        ),
      );

      if (result.isLeft()) {
        throw Exception(result.fold((l) => l.message, (r) => ""));
      }

      final createPostData = result.fold((l) => null, (r) => r);

      if (createPostData is! LensPostResultResponse) {
        String message = 'Unknown error';
        if (createPostData is LensPostResultOperationValidationFailed) {
          final failedRules = createPostData.unsatisfiedRules?.required
                  ?.map((r) => r.message)
                  .join('\n ') ??
              '';
          message = 'Failed to create post: $failedRules';
        } else if (createPostData is LensPostResultTransactionWillFail) {
          message = 'Transaction will fail: ${createPostData.reason}';
        } else if (createPostData
            is LensPostResultSelfFundedTransactionRequest) {
          message = 'Self funded transaction request: ${createPostData.reason}';
        } else if (createPostData
            is LensPostResultSponsoredTransactionRequest) {
          message = 'Sponsored transaction request: ${createPostData.reason}';
        }
        throw Exception('Failed to create post: $message');
      }

      final txHash = createPostData.hash;

      if (txHash == null) {
        throw Exception('Failed to create post: Transaction hash is null');
      }

      final transactionResult =
          await LensUtils.pollTransactionStatus(txHash: txHash);

      if (transactionResult is FailedTransactionStatus) {
        throw Exception(
          'Failed to create post: ${transactionResult.reason}',
        );
      }

      emit(
        CreateLensPostState.success(
          txHash: txHash,
        ),
      );
      _createPostStreamController.add(true);
    } catch (error) {
      _createPostStreamController.add(false);
      emit(
        CreateLensPostState.failed(
          failure: Failure(message: error.toString()),
        ),
      );
    }
  }
}
