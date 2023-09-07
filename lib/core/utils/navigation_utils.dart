import 'package:app/core/data/notification/dtos/notification_dtos.dart';
import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/utils/dialog_utils.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationUtils {
  // ignore: always_declare_return_types
  static handleNotificationNavigate(
    AppRouter appRouter,
    BuildContext context,
    String? type,
    NotificationDto? notification,
  ) {
    if (kDebugMode) {
      print('handleNotificationNavigate');
    }
    if (notification?.refStoreOrder != null) {
      DialogUtils.showAlert(context: context, title: 'Redirect to store order');
    } else if (notification?.refEvent != null) {
      appRouter.navigate(
        GuestEventDetailRoute(eventId: notification?.refEvent ?? ''),
      );
    } else if (notification?.refUser != null) {
      appRouter.navigate(ProfileRoute(userId: notification?.refUser ?? ''));
    }
    switch (type) {
      case NotificationType.userContactSignUp:
      case NotificationType.userFriendshipRequest:
        {
          DialogUtils.showAlert(
            context: context,
            title: 'Trigger create friendship',
          );
          break;
        }
      case NotificationType.eventCohostRequest:
        {
          DialogUtils.showAlert(
            context: context,
            title: 'Trigger accept cohost',
          );
          break;
        }
    }
  }
}
