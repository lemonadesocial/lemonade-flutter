import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/graphql/lens/feed/mutation/lens_create_feed.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'dart:async';

part 'create_lens_feed_bloc.freezed.dart';

@freezed
class CreateLensFeedEvent with _$CreateLensFeedEvent {
  const factory CreateLensFeedEvent.createFeed({
    required String name,
    String? description,
    required List<String> admins,
  }) = _CreateFeed;
}

@freezed
sealed class CreateLensFeedState with _$CreateLensFeedState {
  const factory CreateLensFeedState.initial() = CreateLensFeedInitial;
  const factory CreateLensFeedState.loading() = CreateLensFeedLoading;
  const factory CreateLensFeedState.success({
    required String txHash,
  }) = CreateLensFeedSuccess;
  const factory CreateLensFeedState.failed({
    required Failure failure,
  }) = CreateLensFeedFailed;
}

class CreateLensFeedBloc
    extends Bloc<CreateLensFeedEvent, CreateLensFeedState> {
  final LensRepository _lensRepository;
  final LensGroveService _lensGroveService;

  static final StreamController<bool> _createFeedStreamController =
      StreamController<bool>.broadcast();

  static Stream<bool> get createFeedResultStream =>
      _createFeedStreamController.stream;

  CreateLensFeedBloc(this._lensRepository, this._lensGroveService)
      : super(const CreateLensFeedState.initial()) {
    on<_CreateFeed>(_onCreateFeed);
  }

  Future<void> _onCreateFeed(
    _CreateFeed event,
    Emitter<CreateLensFeedState> emit,
  ) async {
    try {
      emit(const CreateLensFeedState.loading());

      final uploadMetadata = LensUtils.constructLensFeedMetadata(
        name: event.name,
        description: event.description ?? "",
      );

      // Upload metadata to IPFS via Grove
      final uploadResult = await _lensGroveService.uploadJson(uploadMetadata);

      if (uploadResult == null) {
        throw Exception('Failed to upload feed metadata');
      }

      // Create feed request
      final result = await _lensRepository.createFeed(
        input: Variables$Mutation$LensCreateFeed(
          request: Input$CreateFeedRequest(
            admins: event.admins.where((admin) => admin.isNotEmpty).toList(),
            metadataUri: uploadResult['uri'] ?? "",
          ),
        ),
      );

      if (result.isLeft()) {
        throw Exception(result.fold((l) => l.message, (r) => ""));
      }

      final txHash = result.fold(
        (l) => null,
        (r) => r.maybeWhen(
          pendingTransactionStatus: () => null,
          finishedTransactionStatus: (timestamp) => null,
          failedTransactionStatus: (reason, timestamp) => null,
          notIndexedYetStatus: (reason) => reason,
          orElse: () => null,
        ),
      );

      if (txHash == null) {
        throw Exception('Failed to create feed: Transaction hash is null');
      }

      // Poll for transaction status
      final transactionResult =
          await LensUtils.pollTransactionStatus(txHash: txHash);

      if (transactionResult is FailedTransactionStatus) {
        throw Exception(
          'Failed to create feed: ${transactionResult.reason}',
        );
      }

      emit(CreateLensFeedState.success(txHash: txHash));
      _createFeedStreamController.add(true);
    } catch (error) {
      _createFeedStreamController.add(false);
      emit(
        CreateLensFeedState.failed(
          failure: Failure(message: error.toString()),
        ),
      );
    }
  }
}
