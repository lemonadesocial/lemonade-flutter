import 'dart:convert';

class Web3Utils {
  static String formatIdentifier(String address, {int length = 4}) {
    if (address.length < length * 2) {
      return address;
    }

    return '${address.substring(0, length)}...${address.substring(address.length - length)}';
  }

  static String toHex(String text) {
    return '0x' + utf8.encode(text).map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  }
}
