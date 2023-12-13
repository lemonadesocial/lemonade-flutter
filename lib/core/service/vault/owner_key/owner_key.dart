import 'package:app/core/service/vault/owner_key/database/owner_keys_database.dart';
import 'package:app/core/service/vault/owner_key/ethereum_address_json_converter.dart';
import 'package:app/core/service/vault/private_key/private_key.dart';
import 'package:app/injection/register_module.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';

part 'owner_key.freezed.dart';
part 'owner_key.g.dart';

enum OwnerKeyType {
  @JsonValue(0)
  deviceImported,
  @JsonValue(1)
  deviceGenerated,
  @JsonValue(2)
  walletConnect;

  static List<OwnerKeyType> get privateKeyTypes => [
        OwnerKeyType.deviceGenerated,
        OwnerKeyType.deviceGenerated,
      ];
}

@freezed
class OwnerKey with _$OwnerKey {
  OwnerKey._();

  static Future<void> save({
    String? id,
    required String name,
    required OwnerKeyType type,
    required EthereumAddress address,
    PrivateKey? privateKey,
    required int backup,
  }) async {
    assert(backup == 0 || backup == 1);
    var ownerKey = OwnerKey(
      id: id ?? '',
      name: name,
      type: type,
      address: address,
      backup: backup,
    );
    if (OwnerKeyType.privateKeyTypes.contains(type)) {
      assert(privateKey != null);
      ownerKey = ownerKey.copyWith(
        id: privateKey!.id,
      );
      await PrivateKey.save(
        id: privateKey.id,
        privateKey: privateKey,
      );
    }
    await getIt<OwnerKeysDatabase>().insert(ownerKey);
  }

  factory OwnerKey({
    required String id,
    required String name,
    required OwnerKeyType type,
    @EthereumAddressJsonConverter() required EthereumAddress address,
    // 0 || 1 (local db only accept int for boolean)
    required int backup,
    // TODO: wallet
    // TODO: wallet connect active session
  }) = _OwnerKey;

  factory OwnerKey.fromJson(Map<String, dynamic> json) =>
      _$OwnerKeyFromJson(json);
}
