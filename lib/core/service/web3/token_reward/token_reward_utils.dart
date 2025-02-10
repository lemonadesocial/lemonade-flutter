import 'dart:async';
import 'dart:typed_data';
import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class TokenRewardUtils {
  static Future<String> claimReward({
    required TokenRewardVault vault,
    required TokenRewardSignature signature,
    required String from,
  }) async {
    final network = vault.network;
    final chainResult =
        await getIt<Web3Repository>().getChainById(chainId: network ?? '');

    final chain = chainResult.fold(
      (l) => null,
      (r) => r,
    );

    if (chain == null) {
      throw Exception('Chain not found');
    }

    final vaultContract =
        Web3ContractService.getTokenRewardVaultRegistryContract(
      vault.address ?? '',
    );

    // Convert hex strings to Uint8List with proper padding for bytes32
    final claimId = _hexToBytes(
      signature.args?[0] as String,
      padTo32Bytes: true,
    );
    final rewardIds = (signature.args?[1] as List<dynamic>)
        .cast<String>()
        .map(
          (id) => _hexToBytes(
            id,
            padTo32Bytes: true,
          ),
        )
        .toList();
    final counts = (signature.args?[2] as List<dynamic>)
        .cast<int>()
        .map(
          (count) => BigInt.from(count),
        )
        .toList();
    final signatureBytes = _hexToBytes(
      signature.signature ?? '',
    );

    final transaction = Transaction.callContract(
      contract: vaultContract,
      function: vaultContract.function("claimRewards"),
      parameters: [
        claimId, // bytes32
        rewardIds, // bytes32[]
        counts, // uint256[] (BigInt[])
        signatureBytes, // bytes
      ],
    );

    final txHash = await getIt<WalletConnectService>().requestTransaction(
      chainId: chain.fullChainId ?? '',
      transaction: EthereumTransaction(
        from: from,
        to: chain.rewardRegistryContract ?? '',
        value: BigInt.zero.toRadixString(16),
        data: hex.encode(List<int>.from(transaction.data!)),
      ),
    );

    if (!txHash.startsWith('0x')) {
      throw Exception('Invalid transaction hash: $txHash');
    }

    return txHash;
  }

  static Uint8List _hexToBytes(String hex, {bool padTo32Bytes = false}) {
    // Remove '0x' prefix if present
    hex = hex.startsWith('0x') ? hex.substring(2) : hex;

    // Ensure even length
    if (hex.length % 2 != 0) {
      hex = '0$hex';
    }

    // For bytes32, pad to 32 bytes (64 hex characters)
    if (padTo32Bytes && hex.length < 64) {
      hex = hex.padLeft(64, '0');
    }

    final bytes = Uint8List.fromList(
      List.generate(hex.length ~/ 2, (i) {
        return int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
      }),
    );

    return bytes;
  }
}
