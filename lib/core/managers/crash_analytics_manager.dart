import 'package:app/core/service/crash_analytics/crash_analytics_service.dart';
import 'package:app/core/service/crash_analytics/sentry_crash_analytics_service.dart';

/// Crash analytics provider support
enum CrashAnalyticsProvider { sentry }

class CrashAnalyticsManager {
  static final CrashAnalyticsManager _instance =
      CrashAnalyticsManager._internal();
  factory CrashAnalyticsManager() => _instance;

  CrashAnalyticsManager._internal();
  CrashAnalyticsService? _crashAnalyticsService;

  void initialize(CrashAnalyticsProvider provider) {
    switch (provider) {
      case CrashAnalyticsProvider.sentry:
        _crashAnalyticsService = SentryCrashAnalyticsService();
        break;
    }
  }

  CrashAnalyticsService? get crashAnalyticsService => _crashAnalyticsService;
}
