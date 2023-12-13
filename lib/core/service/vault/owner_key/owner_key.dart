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
  walletConnect
}

@freezed
class OwnerKey with _$OwnerKey {
  OwnerKey._();

  factory OwnerKey({
    required String id,
    required String name,
    required OwnerKeyType type,
    @EthereumAddressJsonConverter() required EthereumAddress address,
    // 0 || 1 (local db only accept int for boolean)
    @Default(0) required int backup,
    // TODO: wallet
    // TODO: wallet connect active session
  }) = _OwnerKey;

  factory OwnerKey.fromJson(Map<String, dynamic> json) =>
      _$OwnerKeyFromJson(json);
}

extension OwnerKeyPersistence on OwnerKey {
  Future<void> saveOwnerKeyWithPrivateKey({
    required String name,
    required OwnerKeyType type,
    required PrivateKey privateKey,
    required int backup,
  }) async {
    assert(type != OwnerKeyType.walletConnect);
    assert(backup == 0 || backup == 1);
    final ownerKey = OwnerKey(
      id: privateKey.id,
      name: name,
      type: type,
      address: address,
      backup: backup,
    );

    await getIt<OwnerKeysDatabase>().insert(ownerKey);
    await PrivateKey.save(
      id: privateKey.id,
      privateKey: privateKey,
    );
  }
}
