import 'dart:convert';
import 'package:app/core/service/vault/private_key/pk_data_json_converter.dart';
import 'package:app/core/service/storage/secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

part 'private_key.freezed.dart';
part 'private_key.g.dart';

const keychainPrivateKeyPrefix = 'lemonade.owner.key';
const defaultPath = "m/44'/60'/0'/0";

@freezed
class PrivateKey with _$PrivateKey {
  PrivateKey._();

  static Future<void> save({
    required String id,
    required PrivateKey privateKey,
  }) async {
    final existed = await secureStorage.containsKey(key: id);
    if (existed) {
      throw Exception('Key existed');
    }
    await secureStorage.write(
      key: id,
      value: jsonEncode(
        privateKey.toJson(),
      ),
    );
  }

  static Future<PrivateKey?> get(String id) async {
    final jsonString = await secureStorage.read(key: id);
    if (jsonString == null) {
      throw Exception('Failed to retrieve private key from secure storage');
    }
    final jsonResult = jsonDecode(jsonString);
    return PrivateKey.fromJson(jsonResult);
  }

  static Future<void> remove(String id) async {
    return secureStorage.delete(key: id);
  }

  static Future<void> removeAll() async {
    final allKeyValues = await secureStorage.readAll();
    final filteredKeys = allKeyValues.keys
        .where(
          (key) => key.startsWith(
            keychainPrivateKeyPrefix,
          ),
        )
        .toList();
    return await Future.forEach(filteredKeys, (key) {
      return secureStorage.delete(key: key);
    });
  }

  factory PrivateKey({
    required String id,
    @PkDataJsonConverter() required EthPrivateKey credential,
  }) = _PrivateKey;

  factory PrivateKey.fromJson(Map<String, dynamic> json) =>
      _$PrivateKeyFromJson(json);

  factory PrivateKey.fromMnemonic(String mnemonic, int index) {
    final isValidMnemonic = bip39.validateMnemonic(mnemonic);
    if (!isValidMnemonic) {
      throw Exception('Invalid mnemonic');
    }
    final seed = bip39.mnemonicToSeed(mnemonic);
    final rootNode = bip32.BIP32.fromSeed(seed);
    final prefixNode = rootNode.derivePath(defaultPath);
    final keyNode = prefixNode.derive(index);

    if (keyNode.privateKey == null) {
      throw Exception('Failed to generate a private key');
    }

    final credential = EthPrivateKey(keyNode.privateKey!);

    return PrivateKey(
      id: PrivateKey.identifier(credential.address),
      credential: credential,
    );
  }

  static identifier(EthereumAddress address) =>
      '$keychainPrivateKeyPrefix:${address.hexEip55}';
}
