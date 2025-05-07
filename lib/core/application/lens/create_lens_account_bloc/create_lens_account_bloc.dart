import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_create_account.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/graphql/lens/account/mutation/lens_create_account.graphql.dart';
import 'package:app/graphql/lens/account/mutation/lens_switch_account.graphql.dart';
import 'package:app/graphql/lens/account/query/lens_get_account.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'dart:async';

part 'create_lens_account_bloc.freezed.dart';

@freezed
class CreateLensAccountEvent with _$CreateLensAccountEvent {
  const factory CreateLensAccountEvent.requestCreateLensAccount({
    required String username,
  }) = RequestCreateLensAccount;
}

@freezed
sealed class CreateLensAccountState with _$CreateLensAccountState {
  const factory CreateLensAccountState.initial() = CreateLensAccountInitial;
  const factory CreateLensAccountState.loading() = CreateLensAccountLoading;
  const factory CreateLensAccountState.success({
    required String accessToken,
    required String refreshToken,
    required LensAccount account,
    String? idToken,
  }) = CreateLensAccountSuccess;
  const factory CreateLensAccountState.failed({
    required Failure failure,
  }) = CreateLensAccountFailed;
}

class CreateLensAccountBloc
    extends Bloc<CreateLensAccountEvent, CreateLensAccountState> {
  final LensRepository _lensRepository;
  final LensGroveService _lensGroveService;

  CreateLensAccountBloc(this._lensRepository, this._lensGroveService)
      : super(const CreateLensAccountState.initial()) {
    on<RequestCreateLensAccount>(_onRequestCreateLensAccount);
  }

  Future<void> _onRequestCreateLensAccount(
    RequestCreateLensAccount event,
    Emitter<CreateLensAccountState> emit,
  ) async {
    try {
      emit(const CreateLensAccountState.loading());

      final lensUsername = event.username;

      final newAccountMetadata = LensUtils.constructLensAccountMetadata(
        username: event.username,
      );

      // TODO: upload metadata
      final uploadResult =
          await _lensGroveService.uploadJson(newAccountMetadata);

      if (uploadResult == null) {
        throw Exception('Failed to upload metadata');
      }

      final result = await _lensRepository.createAccountWithUsername(
        input: Variables$Mutation$LensCreateAccountWithUsername(
          request: Input$CreateAccountWithUsernameRequest(
            username: Input$UsernameInput(
              localName: lensUsername,
            ),
            metadataUri: uploadResult['uri'] ?? '',
          ),
        ),
      );

      if (result.isLeft()) {
        throw Exception(result.fold((l) => l.message, (r) => ""));
      }

      final createAccountData = result.fold((l) => null, (r) => r);

      if (createAccountData is! CreateAccountResponse) {
        String message = 'Unknown error';
        if (createAccountData is UsernameTaken) {
          message = 'Username taken';
        } else if (createAccountData is NamespaceOperationValidationFailed) {
          message = 'Namespace operation validation failed';
        } else if (createAccountData is TransactionWillFail) {
          message = 'Transaction will fail';
        } else if (createAccountData is SelfFundedTransactionRequest) {
          message = 'Self funded transaction request';
        } else if (createAccountData is SponsoredTransactionRequest) {
          message = 'Sponsored transaction request';
        }
        throw Exception('Failed to create account: $message');
      }

      final txHash = createAccountData.hash;

      final transactionResult =
          await LensUtils.pollTransactionStatus(txHash: txHash);

      if (transactionResult is FailedTransactionStatus) {
        throw Exception(
          'Failed to create account: ${transactionResult.reason}',
        );
      }

      final lensAccountResult = await _lensRepository.getAccount(
        input: Variables$Query$Account(
          request: Input$AccountRequest(
            txHash: txHash,
          ),
        ),
      );

      if (lensAccountResult.isLeft()) {
        throw Exception('Failed to get account');
      }
      final lensAccount = lensAccountResult.fold((l) => null, (r) => r);

      if (lensAccount == null || lensAccount.address == null) {
        throw Exception('Failed to get account');
      }

      final switchAccountResult = await _lensRepository.switchAccount(
        input: Variables$Mutation$SwitchAccount(
          request: Input$SwitchAccountRequest(
            account: lensAccount.address!,
          ),
        ),
      );
      switchAccountResult.fold((l) {
        emit(
          CreateLensAccountState.failed(
            failure: Failure(message: l.message),
          ),
        );
      }, (result) {
        result.when(
          tokens: (accessToken, refreshToken) {
            emit(
              CreateLensAccountState.success(
                accessToken: accessToken!,
                refreshToken: refreshToken!,
                account: lensAccount,
              ),
            );
          },
          forbiddenError: (forbiddenError) {
            emit(
              CreateLensAccountState.failed(
                failure: Failure(
                  message: forbiddenError,
                ),
              ),
            );
          },
        );
      });
    } catch (error) {
      emit(
        CreateLensAccountState.failed(
          failure: Failure(message: error.toString()),
        ),
      );
    }
  }
}
