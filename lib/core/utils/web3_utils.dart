import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/chain_metadata.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:intl/intl.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class Web3Utils {
  static String formatIdentifier(String address, {int length = 4}) {
    if (address.length < length * 2) {
      return address;
    }

    return '${address.substring(0, length)}...${address.substring(address.length - length)}';
  }

  static String toHex(String text) {
    return '0x${utf8.encode(text).map((e) => e.toRadixString(16).padLeft(2, '0')).join()}';
  }

  static String formatCryptoCurrency(
    BigInt value, {
    required String currency,
    required int decimals,
    int? decimalDigits = 6,
  }) {
    final amount = getAmountByDecimals(value, decimals: decimals);
    final formatter = NumberFormat.decimalPatternDigits(
      decimalDigits: decimalDigits,
    );

    return removeTrailingZeros('${formatter.format(amount)} $currency').trim();
  }

  static ChainMetadata? getNetworkMetadataById(String id) {
    return Chains.allChains.firstWhereOrNull((chain) => chain.id == id);
  }

  static double getAmountByDecimals(
    BigInt amount, {
    required int decimals,
  }) {
    return amount / BigInt.from(pow(10, decimals));
  }

  static Future<BigInt> estimateGasFee(
    Chain network, {
    required EthereumAddress sender,
    required EthereumAddress to,
    required Uint8List data,
  }) async {
    final rpcClient = Web3Client(network.rpcUrl!, http.Client());
    final gasPrice = await rpcClient.getGasPrice();
    final gasLimit = await rpcClient.estimateGas(
      sender: sender,
      to: to,
      data: data,
    );
    return (gasLimit * gasPrice.getInWei);
  }

  static Future<BigInt> getBalance(
    EthereumAddress address, {
    required Chain network,
  }) async {
    final rpcClient = Web3Client(network.rpcUrl!, http.Client());
    final etherAmount = await rpcClient.getBalance(address);
    return etherAmount.getInWei;
  }

  static String removeTrailingZeros(String n) {
    return n.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }

  static Future<TransactionReceipt?> waitForReceipt({
    required String rpcUrl,
    required String txHash,
    int maxAttempt = 10,
    Duration? deplayDuration,
  }) async {
    final web3Client = Web3Client(rpcUrl, http.Client());
    TransactionReceipt? receipt;
    int remainingAttempt = maxAttempt;
    while (remainingAttempt > 0) {
      await Future.delayed(
        deplayDuration ??
            const Duration(
              seconds: 0,
            ),
      );
      receipt = await web3Client.getTransactionReceipt(txHash);
      if (receipt != null) {
        return receipt;
      }
      remainingAttempt--;
    }

    return receipt;
  }

  static Future<String> approveSpender({
    required String erc20Address,
    required String from,
    required String spender,
    required BigInt amount,
    required Chain chain,
  }) async {
    final erc20Contract = Web3ContractService.getERC20Contract(
      erc20Address,
    );
    final approveContractCall = Transaction.callContract(
      contract: erc20Contract,
      function: erc20Contract.function('approve'),
      parameters: [
        EthereumAddress.fromHex(
          spender,
        ),
        amount,
      ],
    );
    final ethereumTxn = EthereumTransaction(
      from: from,
      to: erc20Address,
      value: BigInt.zero.toRadixString(16),
      data: hex.encode(List<int>.from(approveContractCall.data!)),
    );
    final txHash = await getIt<WalletConnectService>().requestTransaction(
      chainId: chain.fullChainId ?? '',
      transaction: ethereumTxn,
    );
    if (txHash.isEmpty || !txHash.startsWith("0x")) {
      throw Exception(txHash);
    }
    await Future.delayed(
      Duration(seconds: chain.completedBlockTime),
    );
    final receipt = await Web3Utils.waitForReceipt(
      rpcUrl: chain.rpcUrl ?? '',
      txHash: txHash,
      maxAttempt: 20,
      deplayDuration: const Duration(seconds: 5),
    );
    if (receipt?.status != true) {
      throw Exception('Failed to approve ERC20: $txHash');
    }
    return txHash;
  }

  static Uint8List hexToBytes(
    String hex, {
    bool padTo32Bytes = false,
  }) {
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

  static String bytesToHex(Uint8List bytes, {bool prefix = true}) {
    final hexString = hex.encode(bytes);
    return prefix ? '0x$hexString' : hexString;
  }

  static BigInt percentToPPM(double percentage) {
    return BigInt.from(percentage * 10000);
  }

  static String concatHex(List<String> values) {
    String concatenatedHex =
        values.fold('', (acc, x) => acc + x.replaceAll('0x', ''));
    String hexWithPrefix = '0x$concatenatedHex';
    return hexWithPrefix;
  }
}
