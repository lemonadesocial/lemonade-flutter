import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:dartz/dartz.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

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
      String? paymentSplitter = '';
      int attempt = 0;
      final web3Client = Web3Client(
        chain.rpcUrl ?? '',
        http.Client(),
      );
      while (paymentSplitter?.isEmpty == true || attempt < 5) {
        await Future.delayed(const Duration(seconds: 3));
        final receipt = await web3Client.getTransactionReceipt(txId);
        if (receipt?.logs.isNotEmpty == true) {
          paymentSplitter = receipt?.logs[0].address.toString();
          if (paymentSplitter?.isNotEmpty == true) {
            return Right(paymentSplitter!);
          }
        }
        attempt++;
      }
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }
}
