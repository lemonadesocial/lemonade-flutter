import 'package:app/core/config.dart';

class LemonadeMatrixUtils {
  static String generateMatrixUserId({
    required String lemonadeMatrixLocalpart,
  }) {
    final isProd = AppConfig.isProduction;
    return '@$lemonadeMatrixLocalpart:${isProd ? 'lemonade.social' : 'staging.lemonade.social'}';
  }
}
