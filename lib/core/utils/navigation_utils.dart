import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/data/notification/notification_enums.dart';
import 'package:app/core/utils/dialog_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


class NavigationUtils {

  static handleNotificationNavigate(BuildContext context, String? type, String? objectType, String? objectId) {
    NotificationObjectType? objectTypeEnum = objectTypeMap[objectType ?? ""];
    switch(objectTypeEnum) {
      case NotificationObjectType.StoreOrder: 
        DialogUtils.showAlert(context: context, title: "Redirect to store order");
        break;
      case NotificationObjectType.Event:
        AutoRouter.of(context).navigate(
          EventDetailRoute(eventId: objectId ?? '', eventName: ''),
        );
        break;
      case NotificationObjectType.User:
        AutoRouter.of(context).navigate(
          ProfileRoute(userId: objectId ?? '')
        );
        break;
      default:
        break;
    }
    switch(type) {
      case NotificationType.userContactSignUp:
      case NotificationType.userFriendshipRequest: {
        // TODO: Trigger create fiendship
        DialogUtils.showAlert(context: context, title: "Trigger create friendship");
        break;
      }
      case NotificationType.eventCohostRequest: {
        // TODO: Trigger accept or decline cohost
        DialogUtils.showAlert(context: context, title: "Trigger accept cohost");
        break;
      }
    }
  }
}