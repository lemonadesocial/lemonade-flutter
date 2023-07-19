import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/domain/notification/entities/notification.dart' as NotificationEntities;
import 'package:app/core/utils/dialog_utils.dart';
import 'package:flutter/material.dart';

class NavigationUtils {

  static handleNotificationNavigate(BuildContext context, NotificationEntities.Notification? notification) {
    switch(notification?.object_type) {
      case "StoreOrder": 
        DialogUtils.showAlert(context: context, title: "Redirect to store order");
        break;
      case "Event":
        DialogUtils.showAlert(context: context, title: "Redirect to event detail");
        break;
      case "User":
        DialogUtils.showAlert(context: context, title: "Redirect to user detail");
        break;
      default:
        break;
    }

    switch(notification?.type) {
      case NotificationType.userContactSignUp:
      case NotificationType.userFriendshipRequest: {
        DialogUtils.showAlert(context: context, title: "Trigger create friendship");
        break;
      }
      case NotificationType.eventCohostRequest: {
        DialogUtils.showAlert(context: context, title: "Trigger accept cohost");
        break;
      }
    }
  }
}