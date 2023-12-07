import 'package:app/core/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VaultSecureStorage {
  static const _storage = FlutterSecureStorage();

  static final _vaultPinKey = 'lemonade_${AppConfig.env}:vault:pin_code';

  static Future<void> setPinCode(String pinCode) async {
    await _storage.write(key: _vaultPinKey, value: pinCode);
  }

  static Future<String?> getPinCode() async {
    return await _storage.read(key: _vaultPinKey);
  }
}
