import 'dart:async';

import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/service/crash_analytics/crash_analytics_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryCrashAnalyticsService implements CrashAnalyticsService {
  FutureOr<SentryEvent?> beforeSend(SentryEvent event, {Hint? hint}) async {
    // Don't send server name
    event = event.copyWith(serverName: null);

    if (event.throwable == 'Invalid argument(s): No host specified in URI') {
      return null;
    }
    if (event.throwable.toString() ==
        'MissingPluginException(No implementation found for method setAccelerationSamplingPeriod on channel dev.fluttercommunity.plus/sensors/method)') {
      return null;
    }

    if (event.throwable is OperationException) {
      final exception = event.throwable as OperationException;
      event = event.copyWith(fingerprint: [
        '{{ default }}',
        exception.graphqlErrors.toString(),
        exception.originalStackTrace.toString(),
      ]);
    }
    if (event.throwable is LinkException) {
      final exception = event.throwable as LinkException;
      event = event.copyWith(fingerprint: [
        '{{ default }}',
        exception.originalException.toString(),
        exception.originalStackTrace.toString(),
      ]);
    }
    return event;
  }

  @override
  void setUser(User user) {
    Sentry.configureScope(
      (scope) => scope.setUser(
        SentryUser(
          id: user.userId,
          username: user.username,
        ),
      ),
    );
  }

  @override
  void clearSetUser() {
    Sentry.configureScope((scope) => scope.setUser(null));
  }

  @override
  void setTag(String key, String value) {
    Sentry.configureScope((scope) => scope.setTag(key, value));
  }

  @override
  void captureError(error, StackTrace? stacktrace) async {
    Sentry.captureException(error, stackTrace: stacktrace);
  }

  void sendFeedback({
    String? name,
    String? email,
    String? comments,
  }) async {
    final feedback = SentryUserFeedback(
      eventId: Sentry.lastEventId,
      comments: comments,
      email: email,
      name: name,
    );
    await (HubAdapter()).captureUserFeedback(feedback);
  }
}
