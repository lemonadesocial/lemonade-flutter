import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LensStorageService {
  final _storage = const FlutterSecureStorage();

  static const _keyAccessToken = 'lens_access_token';
  static const _keyRefreshToken = 'lens_refresh_token';
  // Assuming idToken might be needed later, though Lens API v2 focuses on access/refresh
  static const _keyIdToken = 'lens_id_token';

  Future<bool> hasLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  // Method to save all relevant tokens from a response object
  // The exact structure of 'tokenResponse' depends on how you receive it
  // Adjust the parameter type and accessors accordingly
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? idToken, // idToken might be optional or not used
  }) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
    if (idToken != null) {
      await _storage.write(key: _keyIdToken, value: idToken);
    } else {
      // If idToken is null, ensure it's removed from storage if previously set
      await _storage.delete(key: _keyIdToken);
    }
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  Future<String?> getIdToken() async {
    return await _storage.read(key: _keyIdToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyIdToken);
  }
}
