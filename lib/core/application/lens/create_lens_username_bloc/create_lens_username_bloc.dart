import 'package:app/core/config.dart';
import 'package:app/core/domain/lens/entities/lens_transaction_request.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/core/utils/zksync/eip_712_transaction.dart';
import 'package:app/core/utils/zksync/supported_zksync_chains.dart';
import 'package:app/graphql/lens/namespace/mutation/lens_create_username.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';
import 'package:web3dart/web3dart.dart';

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

      await result.parsedData?.createUsername.maybeWhen(
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
        selfFundedTransactionRequest: (response) async {
          final selfFundedTransactionRequest =
              LensSelfFundedTransactionRequest.fromJson(
            response.toJson(),
          );
          try {
            final txHash = await _onSelfFundedTransactionRequested(
              transactionRequest: selfFundedTransactionRequest,
            );

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
        },
        sponsoredTransactionRequest: (response) async {
          final sponsoredTransactionRequest =
              LensSponsoredTransactionRequest.fromJson(response.toJson());
          try {
            final txHash = await _onSponsoredTransactionRequested(
              transactionRequest: sponsoredTransactionRequest,
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
          } catch (error) {
            emit(
              CreateLensUsernameState.failed(
                failure: Failure(message: error.toString()),
              ),
            );
          }
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

  Future<String> _onSponsoredTransactionRequested({
    required LensSponsoredTransactionRequest transactionRequest,
  }) async {
    final raw = transactionRequest.raw;

    final eip712Transaction = ZKSyncEip712Transaction(
      from: raw?.from ?? '',
      to: raw?.to ?? '',
      value: BigInt.parse(raw?.value ?? '0'),
      data: raw?.data ?? '',
      nonce: BigInt.parse(raw?.nonce?.toString() ?? '0'),
      gas: BigInt.parse(raw?.gasLimit?.toString() ?? '0'),
      maxFeePerGas: BigInt.parse(raw?.maxFeePerGas?.toString() ?? '0'),
      maxPriorityFeePerGas:
          BigInt.parse(raw?.maxPriorityFeePerGas?.toString() ?? '0'),
      chainId: BigInt.from(raw?.chainId ?? 0),
      paymaster: raw?.customData?.paymasterParams?.paymaster,
      paymasterInput: raw?.customData?.paymasterParams?.paymasterInput,
      gasPerPubdata:
          BigInt.parse(raw?.customData?.gasPerPubdata?.toString() ?? '0'),
      customSignature: raw?.customData?.customSignature,
      factoryDeps: raw?.customData?.factoryDeps,
    );

    final lensZkSyncChain =
        AppConfig.isProduction ? ZKSyncLensMainnet() : ZKSyncLensTestnet();

    final txHash = await lensZkSyncChain.sendTransaction(
      eip712Transaction,
      getIt<WalletConnectService>(),
    );

    return txHash;
  }

  Future<String> _onSelfFundedTransactionRequested({
    required LensSelfFundedTransactionRequest transactionRequest,
  }) async {
    final raw = transactionRequest.raw;

    final transaction = EthereumTransaction(
      from: EthereumAddress.fromHex(raw?.from ?? '').toString(),
      to: EthereumAddress.fromHex(raw?.to ?? '').toString(),
      value: BigInt.parse(raw?.value ?? '0').toRadixString(16),
      data: raw?.data ?? '',
    );

    final txHash = await getIt<WalletConnectService>().requestTransaction(
      chainId: 'eip155:${raw?.chainId}',
      transaction: transaction,
    );

    return txHash;
  }
}
