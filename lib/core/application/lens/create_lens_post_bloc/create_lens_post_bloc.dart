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
  const factory CreateLensPostEvent.createPost() = _CreatePost;
}

@freezed
sealed class CreateLensPostState with _$CreateLensPostState {
  const factory CreateLensPostState.initial() = CreateLensPostInitial;
  const factory CreateLensPostState.loading() = CreateLensPostLoading;
  const factory CreateLensPostState.success() = CreateLensPostSuccess;
  const factory CreateLensPostState.failed({
    required Failure failure,
  }) = CreateLensPostFailed;
}

class CreateLensPostBloc
    extends Bloc<CreateLensPostEvent, CreateLensPostState> {
  final LensRepository _lensRepository;
  final LensGroveService _lensGroveService;

  CreateLensPostBloc(this._lensRepository, this._lensGroveService)
      : super(const CreateLensPostState.initial()) {
    on<_CreatePost>(_onCreatePost);
  }

  Future<void> _onCreatePost(
    _CreatePost event,
    Emitter<CreateLensPostState> emit,
  ) async {
    try {
      emit(const CreateLensPostState.loading());

      final textOnlyMetadata = LensCreatePostMetadata.textOnly(
        id: const Uuid().v4(),
        content: "This is post test ${DateTime.now().toIso8601String()}",
      );

      Map<String, dynamic> uploadMetadata = {
        "\$schema": LensConstants
            .lensJsonSchemaByPostContent[Enum$MainContentFocus.TEXT_ONLY],
        "lens": textOnlyMetadata.toJson(),
      };

      final uploadResult = await _lensGroveService.uploadJson(uploadMetadata);

      if (uploadResult == null) {
        throw Exception('Failed to upload metadata');
      }

      final result = await _lensRepository.createPost(
        input: Variables$Mutation$LensCreatePost(
          request: Input$CreatePostRequest(
            contentUri: uploadResult['uri'] ?? '',
            // feed: TODO: add post to specific feed
          ),
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

      emit(const CreateLensPostState.success());
    } catch (error) {
      emit(
        CreateLensPostState.failed(
          failure: Failure(message: error.toString()),
        ),
      );
    }
  }
}
