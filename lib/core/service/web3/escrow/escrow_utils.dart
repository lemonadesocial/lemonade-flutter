import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class EscrowUtils {
  static String get escrowFactoryContractAddress =>
      '0x14426E8221231E2C7E0e182Be0f7cBC138AC5246';

  static String get sampleEscrowContractAddress =>
      '0xC5D7B63dCA0af958F71C775f4394E17538944Ae3';

  // Sample response
  // final response = [
  //   [
  //     [
  //         [addres, amount]
  //       ["0x6B175474E89094C44Da98b954EedeAC495271d0F", "5000000000000000000"],
  //       ["0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2", "100000000000000000000"],
  //     ],
  //     [
  //       ["0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2", "25000000000000000000"],
  //     ]
  //   ]
  // ];
  static Future<BigInt?> getFirstDepositAmount({
    required Chain chain,
    required String paymentId,
    required String escrowContractAddress,
  }) async {
    final web3Client = Web3Client(
      chain.rpcUrl ?? '',
      http.Client(),
    );
    final escrowContract =
        Web3ContractService.getEscrowContract(escrowContractAddress);
    final parsedPaymentId = BigInt.parse('0x$paymentId');
    final response = await web3Client.call(
      contract: escrowContract,
      function: escrowContract.function('getDeposits'),
      params: [
        [
          parsedPaymentId,
        ],
      ],
    );

    final result = response.first;
    if (result is! List) {
      return null;
    }
    if (result.isEmpty) {
      return null;
    }
    final paymentDeposits = result.first;
    if (paymentDeposits is! List) {
      return null;
    }
    if (paymentDeposits.isEmpty) {
      return null;
    }
    final firstDeposit = paymentDeposits.first;
    if (firstDeposit is List<dynamic> && firstDeposit.length >= 2) {
      final depositAmount = (firstDeposit[1] as BigInt?) ?? BigInt.zero;
      return depositAmount;
    }
    return null;
  }

  static Future<BigInt?> getRefund({
    required Chain chain,
    required String paymentId,
    required String escrowContractAddress,
  }) async {
    final web3Client = Web3Client(
      chain.rpcUrl ?? '',
      http.Client(),
    );
    final escrowContract =
        Web3ContractService.getEscrowContract(escrowContractAddress);
    final parsedPaymentId = BigInt.parse('0x$paymentId');
    final response = await web3Client.call(
      contract: escrowContract,
      function: escrowContract.function('getRefunds'),
      params: [
        [
          parsedPaymentId,
        ],
      ],
    );

    final result = response.first;
    if (result is! List) {
      return null;
    }
    if (result.isEmpty) {
      return null;
    }
    final refunds = result.first;
    if (refunds is! List) {
      return null;
    }
    if (refunds.isEmpty) {
      return null;
    }

    final allRefundAmount = refunds.fold(BigInt.zero, (total, refund) {
      BigInt refundItemAmount = BigInt.zero;
      if (refund is List<dynamic> && refund.length >= 2) {
        refundItemAmount = (refund[1] as BigInt?) ?? BigInt.zero;
      }
      return total + refundItemAmount;
    });

    return allRefundAmount;
  }

  static Future<dynamic> getRefundPolices() async {
    final web3Client = Web3Client('https://rpc.sepolia.org', http.Client());
    final escrowContract =
        Web3ContractService.getEscrowContract(sampleEscrowContractAddress);
    final response = await web3Client.call(
      contract: escrowContract,
      function: escrowContract.function('getRefundPolicies'),
      params: [],
    );

    final result = response.first;

    return result;
  }

  static Future<TransactionReceipt?> awaitForReceipt(String txHash) async {
    final web3Client = Web3Client('https://rpc.sepolia.org', http.Client());
    TransactionReceipt? receipt;
    int remainingAttemp = 10;
    while (remainingAttemp > 0) {
      await Future.delayed(
        const Duration(
          seconds: 10,
        ),
      );
      receipt = await web3Client.getTransactionReceipt(txHash);
      if (receipt != null) {
        return receipt;
      }
      remainingAttemp--;
    }

    return receipt;
  }

  // Experiment - Please ignore for now
  static Future<String?> createEscrowContract({
    required String userWalletAddress,
    required String chainId,
  }) async {
    final escrowFactoryContract = Web3ContractService.getEscrowFactoryContract(
      escrowFactoryContractAddress,
    );
    final contractCallTxn = Transaction.callContract(
      contract: escrowFactoryContract,
      function: escrowFactoryContract.function('createEscrow'),
      parameters: [
        // owner
        EthereumAddress.fromHex(userWalletAddress),
        // delegates
        [],
        // payees
        [
          EthereumAddress.fromHex(userWalletAddress),
        ],
        // shares
        [
          BigInt.from(1),
        ],
        // hostRefundPercent
        BigInt.from(50),
        // refund policies
        [],
      ],
    );

    final ethereumTxn = EthereumTransaction(
      from: userWalletAddress,
      to: escrowFactoryContractAddress,
      value: '0x0',
      data: hex.encode(List<int>.from(contractCallTxn.data!)),
    );

    final txHash = await getIt<WalletConnectService>().requestTransaction(
      chainId: chainId,
      transaction: ethereumTxn,
    );

    final receipt = await awaitForReceipt(txHash);
    if (receipt == null) {
      return null;
    }
    return null;
  }
}
