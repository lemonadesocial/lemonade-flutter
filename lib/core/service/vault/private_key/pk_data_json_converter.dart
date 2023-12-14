import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';

class PkDataJsonConverter extends JsonConverter<EthPrivateKey, String> {
  const PkDataJsonConverter();

  @override
  EthPrivateKey fromJson(String json) {
    return EthPrivateKey(base64Decode(json));
  }

  @override
  String toJson(EthPrivateKey object) {
    return base64Encode(object.privateKey);
  }
}
