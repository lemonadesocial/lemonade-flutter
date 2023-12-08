import 'package:app/core/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VaultSecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static final _vaultPinKey = 'lemonade_${AppConfig.env}:vault:pin_code';

  static Future<void> setPinCode({
    required String userId,
    required String pinCode,
  }) async {
    await _storage.write(key: '$_vaultPinKey:$userId', value: pinCode);
  }

  static Future<String?> getPinCode(String userId) async {
    return await _storage.read(key: '$_vaultPinKey:$userId');
  }

  static Future<bool> hasPinCode(String userId) async {
    final pinCode = await VaultSecureStorage.getPinCode(userId);
    return pinCode?.isNotEmpty == true;
  }
}
