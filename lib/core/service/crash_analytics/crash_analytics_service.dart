import 'package:app/core/domain/user/entities/user.dart';

abstract class CrashAnalyticsService {
  void setUser(User user);
  void clearSetUser();
  void setTag(String key, String value);
  void captureError(dynamic error, StackTrace? stacktrace);
}
