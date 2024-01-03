import 'dart:async';

import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/raw_transaction.dart';
import 'package:app/core/service/vault/private_key/private_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

part 'deploy_vault_with_owner_key_bloc.freezed.dart';

class DeployVaultWithOwnerKeyBloc
    extends Bloc<DeployVaultWithOwnerKeyEvent, DeployVaultWithOwnerKeyState> {
  StreamSubscription? _subscription;
  DeployVaultWithOwnerKeyBloc() : super(DeployVaultWithOwnerKeyState.idle()) {
    on<DeployVaultWithOwnerKeyEventStartDeploy>(_onStartDeploy);
  }
  int maxAttempt = 20;
  int attempt = 0;

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    super.close();
  }

  Future<void> _onStartDeploy(
    DeployVaultWithOwnerKeyEventStartDeploy event,
    Emitter emit,
  ) async {
    try {
      emit(
        DeployVaultWithOwnerKeyState.loading(),
      );
      final network = event.network;
      final privateKey = await PrivateKey.get(
        PrivateKey.identifier(
          EthereumAddress.fromHex(event.ownerAddress),
        ),
      );

      if (privateKey == null) {
        return emit(
          DeployVaultWithOwnerKeyState.failure(
            failureReason: DeployVaultWithOwnerKeyFailureReason(
              errorMessage: 'You\'re not authorized to make this transaction',
            ),
          ),
        );
      }

      final rpcClient = Web3Client(network.rpcUrl!, http.Client());
      final txHash = await rpcClient.sendTransaction(
        privateKey.credential,
        Transaction(
          from: privateKey.credential.address,
          to: EthereumAddress.fromHex(event.rawTransaction.to!),
          data: hexToBytes(event.rawTransaction.data!),
        ),
        chainId: int.parse(network.chainId!),
      );

      if (_subscription != null) {
        await _subscription?.cancel();
      }
      final receipt = await _checkTxReceipt(
        txHash,
        rpcClient: rpcClient,
      );
      if (receipt == null || receipt.logs.isEmpty) {
        emit(
          DeployVaultWithOwnerKeyState.failure(
            failureReason: DeployVaultWithOwnerKeyFailureReason.withRpcError(
              message: 'There\'s something wrong',
            ),
          ),
        );
      } else {
        emit(
          DeployVaultWithOwnerKeyState.success(
            safeWalletAddress: receipt.logs.first.address?.hex ?? '',
          ),
        );
      }
    } on RPCError catch (e) {
      emit(
        DeployVaultWithOwnerKeyState.failure(
          failureReason: DeployVaultWithOwnerKeyFailureReason.withRpcError(
            message: e.message,
          ),
        ),
      );
    }
  }

  Future<TransactionReceipt?> _checkTxReceipt(
    String txHash, {
    required Web3Client rpcClient,
  }) async {
    attempt++;
    debugPrint("Attempting to get transaction receipt...");
    if (attempt <= maxAttempt) {
      var receipt = await rpcClient
          .getTransactionReceipt(txHash)
          .catchError((value) => null);

      if (receipt != null) {
        return receipt;
      } else {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        return _checkTxReceipt(
          txHash,
          rpcClient: rpcClient,
        );
      }
    } else {
      attempt = 0;
      debugPrint("Max attempts reached.");
      return null;
    }
  }
}

@freezed
class DeployVaultWithOwnerKeyEvent with _$DeployVaultWithOwnerKeyEvent {
  factory DeployVaultWithOwnerKeyEvent.startDeploy({
    required RawTransaction rawTransaction,
    required String ownerAddress,
    required Chain network,
  }) = DeployVaultWithOwnerKeyEventStartDeploy;
}

@freezed
class DeployVaultWithOwnerKeyState with _$DeployVaultWithOwnerKeyState {
  factory DeployVaultWithOwnerKeyState.idle() =
      DeployVaultWithOwnerKeyStateIdle;
  factory DeployVaultWithOwnerKeyState.loading() =
      DeployVaultWithOwnerKeyStateLoading;
  factory DeployVaultWithOwnerKeyState.success({
    required String safeWalletAddress,
  }) = DeployVaultWithOwnerKeyStateSuccess;
  factory DeployVaultWithOwnerKeyState.failure({
    DeployVaultWithOwnerKeyFailureReason? failureReason,
  }) = DeployVaultWithOwnerKeyStateFailure;
}

class DeployVaultWithOwnerKeyFailureReason {
  final String? errorMessage;
  DeployVaultWithOwnerKeyFailureReason({
    this.errorMessage,
  });

  factory DeployVaultWithOwnerKeyFailureReason.withRpcError({
    String? message,
  }) =>
      DeployVaultWithOwnerKeyFailureReason(errorMessage: message);
}
