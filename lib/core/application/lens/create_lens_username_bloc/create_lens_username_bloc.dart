import 'package:app/core/config.dart';
import 'package:app/core/domain/lens/entities/lens_transaction_request.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/graphql/lens/namespace/mutation/lens_create_username.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
  CreateLensUsernameBloc() : super(const CreateLensUsernameState.initial()) {
    on<RequestCreateLensUsername>(_onRequestCreateLensUsername);
  }

  Future<void> _onRequestCreateLensUsername(
    RequestCreateLensUsername event,
    Emitter<CreateLensUsernameState> emit,
  ) async {
    try {
      emit(const CreateLensUsernameState.loading());

      final lensUsername = event.username;

      final result = await getIt<LensGQL>().client.mutate$LensCreateUsername(
            Options$Mutation$LensCreateUsername(
              variables: Variables$Mutation$LensCreateUsername(
                request: Input$CreateUsernameRequest(
                  username: Input$UsernameInput(
                    localName: lensUsername,
                    namespace: AppConfig.lensNamespace,
                  ),
                  // autoAssign: true,
                ),
              ),
            ),
          );

      if (result.hasException) {
        throw Exception(result.exception?.graphqlErrors.first.message);
      }

      result.parsedData?.createUsername.maybeWhen(
        orElse: () {
          throw Exception('Unknown error');
        },
        createUsernameResponse: (response) async {
          final txHash = response.hash;

          final transactionResult =
              await LensUtils.pollTransactionStatus(txHash: txHash);

          if (transactionResult is FailedTransactionStatus) {
            throw Exception(
              'Failed to create username: ${transactionResult.reason}',
            );
          }

          emit(
            CreateLensUsernameState.success(
              txHash: txHash,
            ),
          );
        },
        selfFundedTransactionRequest: (response) {},
        sponsoredTransactionRequest: (response) {
          final sponsoredTransactionRequest =
              LensSponsoredTransactionRequest.fromJson(response.toJson());
          _onSponsoredTransactionRequested(
            transactionRequest: sponsoredTransactionRequest,
            emit: emit,
          );
        },
        transactionWillFail: (response) {
          throw Exception('Transaction failed: ${response.reason}');
        },
        usernameTaken: (response) {
          throw Exception('Username already taken: ${response.reason}');
        },
        namespaceOperationValidationFailed: (response) {
          throw Exception(
            'Namespace operation validation failed: ${response.reason}',
          );
        },
      );
    } catch (error) {
      emit(
        CreateLensUsernameState.failed(
          failure: Failure(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onSponsoredTransactionRequested({
    required LensSponsoredTransactionRequest transactionRequest,
    required Emitter<CreateLensUsernameState> emit,
  }) async {
    final raw = transactionRequest.raw;

    final ethTransaction = EthereumTransaction(
      from: raw?.from ?? '',
      to: raw?.to ?? '',
      value: raw?.value ?? '',
      data: raw?.data ?? '',
      nonce: raw?.nonce?.toString() ?? '',
      gasLimit: raw?.gasLimit?.toString() ?? '',
      maxFeePerGas: raw?.maxFeePerGas?.toString() ?? '',
      maxPriorityFeePerGas: raw?.maxPriorityFeePerGas?.toString() ?? '',
    );

    final txHash = await getIt<WalletConnectService>().requestTransaction(
      chainId: 'eip155:${raw?.chainId}',
      transaction: ethTransaction,
    );

    final transactionResult =
        await LensUtils.pollTransactionStatus(txHash: txHash);

    if (transactionResult is FailedTransactionStatus) {
      throw Exception(
        'Failed to create username: ${transactionResult.reason}',
      );
    }

    emit(
      CreateLensUsernameState.success(
        txHash: txHash,
      ),
    );
  }
}
