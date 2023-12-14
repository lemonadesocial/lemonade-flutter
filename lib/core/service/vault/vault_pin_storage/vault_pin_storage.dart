import 'package:app/core/config.dart';
import 'package:app/core/service/storage/secure_storage.dart';

class VaultPinStorage {
  static final _vaultPinKey = 'lemonade.${AppConfig.env}.vault_pin_code';

  static Future<void> setPinCode({
    required String userId,
    required String pinCode,
  }) async {
    await secureStorage.write(key: '$_vaultPinKey:$userId', value: pinCode);
  }

  static Future<String?> getPinCode(String userId) async {
    return await secureStorage.read(key: '$_vaultPinKey:$userId');
  }

  static Future<bool> hasPinCode(String userId) async {
    final pinCode = await VaultPinStorage.getPinCode(userId);
    return pinCode?.isNotEmpty == true;
  }
}
