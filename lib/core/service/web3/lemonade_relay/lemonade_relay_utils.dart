import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:dartz/dartz.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

class LemonadeRelayUtils {
  static Future<Either<Failure, String>> register({
    required Chain chain,
    required String payeeAddress,
  }) async {
    try {
      final relayContract = Web3ContractService.getRelayPaymentContract(
        chain.relayPaymentContract!,
      );
      final contractCall = Transaction.callContract(
        contract: relayContract,
        function: relayContract.function('register'),
        parameters: [
          [EthereumAddress.fromHex(payeeAddress)],
          // right now only support for 1 person
          [BigInt.from(1)],
        ],
      );
      final ethTx = EthereumTransaction(
        from: payeeAddress,
        to: chain.relayPaymentContract!,
        value: '0x0',
        data: hex.encode(
          List<int>.from(contractCall.data!),
        ),
      );
      final txId = await getIt<WalletConnectService>().requestTransaction(
        chainId: chain.fullChainId ?? '',
        transaction: ethTx,
      );
      await Future.delayed(
        Duration(seconds: chain.completedBlockTime),
      );
      String? paymentSplitter = '';
      final receipt = await Web3Utils.waitForReceipt(
        rpcUrl: chain.rpcUrl ?? '',
        txHash: txId,
        deplayDuration: const Duration(seconds: 3),
      );
      if (receipt?.logs.isNotEmpty == true) {
        paymentSplitter = receipt?.logs[0].address.toString();
        if (paymentSplitter?.isNotEmpty == true) {
          return Right(paymentSplitter!);
        }
      }
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }

  static Future<EthereumAddress> _getPayeeAddress({
    required Chain chain,
    required String paymentSplitterContractAddress,
  }) async {
    final contract = Web3ContractService.getPaymentSplitterContract(
      paymentSplitterContractAddress,
    );
    final web3Client = Web3Client(chain.rpcUrl!, http.Client());
    final data = await web3Client.call(
      contract: contract,
      function: contract.function('allPayees'),
      params: [],
    );
    if (data.isEmpty || data[0].isEmpty) {
      throw Exception('No payee found');
    }
    final payees = data[0];
    // currently only get first payee because we only support 1 payee (event's host)
    return payees[0][0] as EthereumAddress;
  }

  static Future<Either<Failure, String>> claimSplit({
    required String paymentSplitterContractAddress,
    required String connectedWalletAddress,
    required Chain chain,
    required List<ERC20Token> tokens,
  }) async {
    try {
      final contract = Web3ContractService.getPaymentSplitterContract(
        paymentSplitterContractAddress,
      );
      final releaseFunctionWithMultiToken =
          contract.functions.firstWhere((func) {
        final targetParam = func.parameters
            .firstWhereOrNull((element) => element.name == 'currencies');
        return func.name == 'release' && targetParam != null;
      });

      final payeeAddress = await _getPayeeAddress(
        chain: chain,
        paymentSplitterContractAddress: paymentSplitterContractAddress,
      );
      final contractCallTx = Transaction.callContract(
        contract: contract,
        function: releaseFunctionWithMultiToken,
        parameters: [
          tokens
              .map((token) => EthereumAddress.fromHex(token.contract!))
              .toList(),
          payeeAddress,
        ],
      );
      final ethereumTx = EthereumTransaction(
        from: connectedWalletAddress,
        to: paymentSplitterContractAddress,
        value: BigInt.zero.toRadixString(16),
        data: hex.encode(contractCallTx.data!),
      );
      final txHash = await getIt<WalletConnectService>().requestTransaction(
        chainId: chain.fullChainId ?? '',
        transaction: ethereumTx,
      );
      if (!txHash.startsWith('0x')) {
        return Left(Failure(message: txHash));
      }
      await Future.delayed(
        Duration(seconds: chain.completedBlockTime),
      );
      final receipt = await Web3Utils.waitForReceipt(
        rpcUrl: chain.rpcUrl ?? '',
        txHash: txHash,
        deplayDuration: const Duration(seconds: 3),
      );
      if (receipt?.status == true) {
        return Right(txHash);
      }
      return Left(Failure());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  static Future<Either<Failure, List<BigInt>>> getClaimables({
    required String paymentSplitterContractAddress,
    required String userWalletAddress,
    required Chain chain,
    required List<ERC20Token> tokens,
  }) async {
    try {
      final contract = Web3ContractService.getPaymentSplitterContract(
        paymentSplitterContractAddress,
      );
      final pendingFunctionWithMultipleTokens =
          contract.functions.firstWhere((func) {
        final targetParam = func.parameters
            .firstWhereOrNull((element) => element.name == 'currencies');
        return func.name == 'pending' && targetParam != null;
      });
      final web3Client = Web3Client(chain.rpcUrl!, http.Client());
      // currently only get first payee because we only support 1 payee (event's host)
      final payeeAddress = await _getPayeeAddress(
        chain: chain,
        paymentSplitterContractAddress: paymentSplitterContractAddress,
      );
      final tokenAddresses = tokens
          .map((token) => EthereumAddress.fromHex(token.contract!))
          .toList();
      final data = await web3Client.call(
        contract: contract,
        function: pendingFunctionWithMultipleTokens,
        params: [
          tokenAddresses,
          payeeAddress,
        ],
      );

      final amounts = data.isNotEmpty
          ? (data[0] as List<dynamic>).whereType<BigInt>().toList()
          : null;
      if (amounts != null) {
        return Right(amounts);
      }
      return Left(Failure());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
