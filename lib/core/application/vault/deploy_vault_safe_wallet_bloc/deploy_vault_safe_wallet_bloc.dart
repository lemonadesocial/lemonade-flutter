import 'package:app/core/domain/vault/input/get_init_safe_transaction_input/get_init_safe_transaction_input.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deploy_vault_safe_wallet_bloc.freezed.dart';

class DeployVaultSafeWalletBloc
    extends Bloc<DeployVaultSafeWalletEvent, DeployVaultSafeWalletState> {
  DeployVaultSafeWalletBloc() : super(DeployVaultSafeWalletState.idle()) {
    on<DeployVaultSafeWalletEvent>((event, emit) {
      // TODO: implement event handler
    });
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
