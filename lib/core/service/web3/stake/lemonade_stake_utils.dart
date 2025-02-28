import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:http/http.dart' as http;

class LemonadeStakeUtils {
  static Future<String> getPayoutAddress({
    required Chain chain,
    required String configId,
  }) async {
    final client = Web3Client(chain.rpcUrl ?? '', http.Client());
    final contract = Web3ContractService.getStakeVaultContract(configId);
    final result = await client.call(
      contract: contract,
      function: contract.function('payoutAddress'),
      params: [],
    );
    return (result.first as EthereumAddress).hexEip55;
  }

  static Future<double> getRefundPercentage({
    required Chain chain,
    required String configId,
  }) async {
    final client = Web3Client(chain.rpcUrl ?? '', http.Client());
    final contract = Web3ContractService.getStakeVaultContract(configId);
    final result = await client.call(
      contract: contract,
      function: contract.function('refundPPM'),
      params: [],
    );
    return ((result.first as BigInt) / BigInt.from(10000)).toDouble();
  }
}
