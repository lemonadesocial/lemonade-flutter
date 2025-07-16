import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMethod { wallet, oauth }

@lazySingleton
class AuthMethodTracker {
  Future<void> setAuthMethod(AuthMethod method) async {
    final authMethod = method.name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_method', authMethod);
  }

  Future<AuthMethod?> getAuthMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final authMethod = prefs.getString('auth_method');
    return authMethod != null ? AuthMethod.values.byName(authMethod) : null;
  }

  Future<void> clearAuthMethod() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_method');
  }
}
