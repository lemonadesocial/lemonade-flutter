import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/chain_metadata.dart';
import 'package:collection/collection.dart';
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
}
