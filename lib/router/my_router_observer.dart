import 'package:auto_route/auto_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MyRouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('New route pushed: ${route.settings.name}');
    }
    logScreen(route.settings.name);
  }

  /// called when a tab route activates
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (kDebugMode) {
      print('Tab route visited: ${route.name}');
    }
    logScreen(route.name);
  }

  /// called when tab route reactivates
  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (kDebugMode) {
      print('Tab route re-visited: ${route.name}');
    }
    logScreen(route.name);
  }

  void logScreen(screenName) {
    try {
      if (screenName == null || screenName == '') {
        return;
      }
      FirebaseCrashlytics.instance.log(screenName);
      FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
      // ignore: empty_catches
    } catch (e) {}
  }
}
