import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:web3dart/web3dart.dart';
import 'package:convert/convert.dart';

class LemonadeStakeVaultFactory {
  final Chain _chain;

  LemonadeStakeVaultFactory({
    required Chain chain,
  }) : _chain = chain;

  Future<Either<Failure, String>> createVault({
    required String userWalletAddress,
    required String payoutAddress,
    required double percentage,
    required String salt,
  }) async {
    try {
      final contract = Web3ContractService.getStakeFactoryContract(
        _chain.stakePaymentContract ?? '',
      );

      final registerFunction = contract.function('register');

      final transaction = Transaction.callContract(
        contract: contract,
        function: registerFunction,
        parameters: [
          Web3Utils.hexToBytes(salt),
          EthereumAddress.fromHex(payoutAddress),
          Web3Utils.percentToPPM(percentage),
        ],
      );

      final ethereumTransaction = EthereumTransaction(
        from: userWalletAddress,
        to: _chain.stakePaymentContract ?? '',
        data: hex.encode(transaction.data!),
        value: '0',
      );
      // Send the transaction
      final txHash = await getIt<WalletConnectService>().requestTransaction(
        transaction: ethereumTransaction,
        chainId: _chain.fullChainId!,
      );
      if (!txHash.startsWith('0x')) {
        return Left(Failure(message: txHash));
      }
      return Right(txHash);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getVaultAddressFromTransaction(
    String txHash, {
    int maxAttempts = 10,
    int initialDelay = 1000,
  }) async {
    try {
      final receipt = await Web3Utils.waitForReceipt(
        txHash: txHash,
        maxAttempt: maxAttempts,
        rpcUrl: _chain.rpcUrl ?? '',
      );

      if (receipt == null) return Left(Failure(message: 'Receipt not found'));

      final contract = Web3ContractService.getStakeFactoryContract(
        _chain.stakePaymentContract ?? '',
      );

      final vaultRegisteredEvent = contract.event('VaultRegistered');
      final signatureHex = Web3Utils.bytesToHex(vaultRegisteredEvent.signature);

      for (final log in receipt.logs) {
        if (log.topics != null &&
            log.topics!.isNotEmpty &&
            log.topics!.first == signatureHex) {
          final decodedEvent = vaultRegisteredEvent.decodeResults(
            log.topics ?? [],
            log.data ?? '',
          );
          final vaultAddress = (decodedEvent[0] as EthereumAddress).hexEip55;
          return Right(vaultAddress);
        }
      }
      return Left(
        Failure(
          message: 'Failed to find vault address from tx hash: $txHash',
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
