import 'dart:convert';
import 'dart:math';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/web3/entities/chain_metadata.dart';

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

  static formatCryptoCurrency(
    BigInt value, {
    required String currency,
    required int decimals,
  }) {
    return '${(value / BigInt.from(pow(10, decimals)))} $currency';
  }

  static ChainMetadata getNetworkMetadataById(String id) {
    return Chains.allChains.firstWhere((chain) => chain.id == id);
  }
}
