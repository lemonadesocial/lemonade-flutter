import 'package:app/core/config.dart';
import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:app/core/service/crash_analytics/sentry_crash_analytics_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> setupSentry(
  AppRunner appRunner,
) async {
  await SentryFlutter.init(
    (options) {
      options.environment = AppConfig.env;
      options.dsn = AppConfig.sentryDsn;
      options.beforeSend = (CrashAnalyticsManager().crashAnalyticsService
              as SentryCrashAnalyticsService)
          .beforeSend;
      options.sendDefaultPii = true;
      options.reportSilentFlutterErrors = true;
      options.attachScreenshot = true;
      options.screenshotQuality = SentryScreenshotQuality.low;
      options.attachViewHierarchy = true;
      options.maxRequestBodySize = MaxRequestBodySize.always;
      options.maxResponseBodySize = MaxResponseBodySize.always;
    },
    // Init your App.
    appRunner: appRunner,
  );
}
