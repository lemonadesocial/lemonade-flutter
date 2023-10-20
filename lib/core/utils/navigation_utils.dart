import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationUtils {
  // ignore: always_declare_return_types
  static handleNotificationNavigate(
    BuildContext context,
    notification_entities.Notification? notification,
  ) {
    String? type = notification?.type;
    if (kDebugMode) {
      print('handleNotificationNavigate');
    }
    if (notification?.refEvent != null) {
      AutoRouter.of(context).navigate(
        GuestEventDetailRoute(
          eventId: notification?.refEvent ?? '',
        ),
      );
    } else if (notification?.refUser != null) {
      AutoRouter.of(context).navigate(
        ProfileRoute(
          userId: notification?.refUser ?? '',
        ),
      );
    }
    switch (type) {
      case NotificationType.userContactSignUp:
      case NotificationType.userFriendshipRequest:
        {
          AutoRouter.of(context).navigate(
            ProfileRoute(
              userId: notification?.from ?? '',
            ),
          );
          break;
        }
      case NotificationType.eventCohostRequest:
        {
          AutoRouter.of(context).navigate(
            ProfileRoute(
              userId: notification?.from ?? '',
            ),
          );
          break;
        }
    }
  }
}
