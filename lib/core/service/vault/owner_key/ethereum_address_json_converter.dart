import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';

class EthereumAddressJsonConverter
    extends JsonConverter<EthereumAddress, String> {
  const EthereumAddressJsonConverter();

  @override
  EthereumAddress fromJson(String json) {
    return EthereumAddress(base64Decode(json));
  }

  @override
  String toJson(EthereumAddress object) {
    return base64Encode(object.addressBytes);
  }
}
