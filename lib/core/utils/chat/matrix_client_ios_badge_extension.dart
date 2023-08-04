import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:matrix/matrix.dart';

extension IosBadgeClientExtension on Client {
  void updateIosBadge() {
    if (Platform.isIOS) {
      // Workaround for iOS not clearing notifications with fcm_shared_isolate
      if (!rooms.any(
        (r) => r.membership == Membership.invite || (r.notificationCount > 0),
      )) {
        // ignore: unawaited_futures
        FlutterLocalNotificationsPlugin().cancelAll();
      }
    }
  }
}
