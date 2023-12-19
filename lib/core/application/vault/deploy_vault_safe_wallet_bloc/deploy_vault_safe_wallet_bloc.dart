import 'package:app/core/domain/vault/input/get_init_safe_transaction_input/get_init_safe_transaction_input.dart';
import 'package:app/core/domain/vault/vault_repository.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/domain/web3/entities/raw_transaction.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

part 'deploy_vault_safe_wallet_bloc.freezed.dart';

class DeployVaultSafeWalletBloc
    extends Bloc<DeployVaultSafeWalletEvent, DeployVaultSafeWalletState> {
  final vaultRepository = getIt<VaultRepository>();
  DeployVaultSafeWalletBloc() : super(DeployVaultSafeWalletState.idle()) {
    on<DeployVaultSafeWalletEventStartDeploy>(_onStartDeploy);
  }

  Future<void> _onStartDeploy(
    DeployVaultSafeWalletEventStartDeploy event,
    Emitter emit,
  ) async {
    try {
      final result =
          await vaultRepository.getInitSafeTransaction(input: event.input);

      if (result.isLeft()) {
        return emit(
          DeployVaultSafeWalletState.failure(
            failureReason: GetTransactionPayloadFailure(),
          ),
        );
      }
      final initSafeTransactionData = result.getOrElse(() => RawTransaction());
      final txHash = await getIt<WalletConnectService>().requestTransaction(
        chainId: event.network.fullChainId!,
        transaction: EthereumTransaction(
          from: event.userWalletAddress,
          to: initSafeTransactionData.to ?? '',
          value: initSafeTransactionData.value ?? '0x0',
          data: initSafeTransactionData.data ?? '',
        ),
        walletApp: SupportedWalletApp.metamask,
      );
      final rpcClient = Web3Client(event.network.rpcUrl!, http.Client());
      final receipt = await rpcClient.getTransactionReceipt(txHash);
      if (receipt == null || receipt.logs.isEmpty) {
        return emit(
          DeployVaultSafeWalletState.failure(
            failureReason: GetTransactionReceiptFailure(),
          ),
        );
      }
      emit(
        DeployVaultSafeWalletState.success(
          safeWalletAddress: receipt.logs.first.address?.hex ?? '',
          owners: event.input.owners,
          threshold: event.input.threshold,
          network: event.network,
        ),
      );
    } catch (error) {
      emit(
        DeployVaultSafeWalletState.failure(
          failureReason: DeploySafeWalletFailure(),
        ),
      );
    }
  }
}

@freezed
class DeployVaultSafeWalletEvent with _$DeployVaultSafeWalletEvent {
  factory DeployVaultSafeWalletEvent.startDeploy({
    required String userWalletAddress,
    required Chain network,
    required GetInitSafeTransactionInput input,
  }) = DeployVaultSafeWalletEventStartDeploy;
}

@freezed
class DeployVaultSafeWalletState with _$DeployVaultSafeWalletState {
  factory DeployVaultSafeWalletState.idle() = DeployVaultSafeWalletIdle;
  factory DeployVaultSafeWalletState.loading() = DeployVaultSafeWalletLoading;
  factory DeployVaultSafeWalletState.success({
    required String safeWalletAddress,
    required List<String> owners,
    required int threshold,
    required Chain network,
  }) = DeployVaultSafeWalletSuccess;
  factory DeployVaultSafeWalletState.failure({
    required DeploySafeWalletFailure failureReason,
  }) = DeployVaultSafeWalletFailure;
}

class DeploySafeWalletFailure {}

class GetTransactionPayloadFailure extends DeploySafeWalletFailure {}

class TransactionFailure extends DeploySafeWalletFailure {}

class GetTransactionReceiptFailure extends DeploySafeWalletFailure {}
