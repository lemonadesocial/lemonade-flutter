import 'package:app/core/config.dart';
import 'package:app/core/domain/lens/entities/lens_create_username.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/graphql/lens/namespace/mutation/lens_create_username.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'dart:async';

part 'create_lens_username_bloc.freezed.dart';

@freezed
class CreateLensUsernameEvent with _$CreateLensUsernameEvent {
  const factory CreateLensUsernameEvent.requestCreateLensUsername({
    required String username,
  }) = RequestCreateLensUsername;
}

@freezed
sealed class CreateLensUsernameState with _$CreateLensUsernameState {
  const factory CreateLensUsernameState.initial() = CreateLensUsernameInitial;
  const factory CreateLensUsernameState.loading() = CreateLensUsernameLoading;
  const factory CreateLensUsernameState.success({
    required String txHash,
  }) = CreateLensUsernameSuccess;
  const factory CreateLensUsernameState.failed({
    required Failure failure,
  }) = CreateLensUsernameFailed;
}

class CreateLensUsernameBloc
    extends Bloc<CreateLensUsernameEvent, CreateLensUsernameState> {
  final LensRepository _lensRepository;

  CreateLensUsernameBloc(
    this._lensRepository,
  ) : super(const CreateLensUsernameState.initial()) {
    on<RequestCreateLensUsername>(_onRequestCreateLensUsername);
  }

  Future<void> _onRequestCreateLensUsername(
    RequestCreateLensUsername event,
    Emitter<CreateLensUsernameState> emit,
  ) async {
    try {
      emit(const CreateLensUsernameState.loading());

      final lensUsername = event.username;

      final result = await _lensRepository.createUsername(
        input: Variables$Mutation$LensCreateUsername(
          request: Input$CreateUsernameRequest(
            username: Input$UsernameInput(
              localName: lensUsername,
              namespace: AppConfig.lensNamespace,
            ),
            autoAssign: true,
          ),
        ),
      );

      if (result.isLeft()) {
        throw Exception(result.fold((l) => l.message, (r) => ""));
      }

      final createUsernameData = result.fold((l) => null, (r) => r);

      if (createUsernameData is! CreateUsernameResponse) {
        String message = 'Unknown error';
        if (createUsernameData is UsernameTaken) {
          message = 'Username taken';
        } else if (createUsernameData is NamespaceOperationValidationFailed) {
          message = 'Namespace operation validation failed';
        } else if (createUsernameData is TransactionWillFail) {
          message = 'Transaction will fail';
        } else if (createUsernameData is SelfFundedTransactionRequest) {
          message = 'Self funded transaction request';
          _onTransactionRequested(
            username: lensUsername,
            raw: createUsernameData.eip712TransactionRequest!,
            emit: emit,
          );
          return;
        } else if (createUsernameData is SponsoredTransactionRequest) {
          message = 'Sponsored transaction request';
        }
        throw Exception('Failed to create account: $message');
      }

      final txHash = createUsernameData.hash;

      final transactionResult =
          await LensUtils.pollTransactionStatus(txHash: txHash);

      if (transactionResult is FailedTransactionStatus) {
        throw Exception(
          'Failed to create username: ${transactionResult.reason}',
        );
      }
    } catch (error) {
      emit(
        CreateLensUsernameState.failed(
          failure: Failure(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onTransactionRequested({
    required String username,
    required Eip712TransactionRequest raw,
    required Emitter<CreateLensUsernameState> emit,
  }) async {
    // TODO: call transaction
    // TODO: call create username again

    // emit(
    //   CreateLensUsernameState.failed(
    //       failure: Failure(message: result.data),
    //     ),
    //   );
  }
}
