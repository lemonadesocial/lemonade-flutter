import 'package:app/core/application/notification/delete_notifications_bloc/delete_notifications_bloc.dart';
import 'package:app/core/domain/notification/input/delete_notifications_input.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/default_notification_item.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/event_invited_notification_item.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/event_join_request_notification_item.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/event_ticket_assigned_notification_item.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/event_update_notification_item.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/friend_request_notification_item.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/payment_notification_item.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_slidable_widget.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCard extends StatelessWidget {
  final notification_entities.Notification notification;
  final int index;
  final Function()? onTap;
  final Function(
    int index,
    notification_entities.Notification notification,
    bool? isDismiss,
  )? onRemove;

  const NotificationCard({
    super.key,
    required this.index,
    required this.notification,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteNotificationsBloc(),
      child: NotificationCardView(
        index: index,
        notification: notification,
        onTap: onTap,
        onRemove: onRemove,
      ),
    );
  }
}

class NotificationCardView extends StatelessWidget {
  final notification_entities.Notification notification;
  final int index;
  final Function()? onTap;
  final Function(
    int index,
    notification_entities.Notification notification,
    bool? isDismiss,
  )? onRemove;

  const NotificationCardView({
    super.key,
    required this.index,
    required this.notification,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationSlidable(
      id: notification.id ?? '',
      onRemove: () {
        context.read<DeleteNotificationsBloc>().add(
              DeleteNotificationsEvent.delete(
                input: DeleteNotificationsInput(
                  ids: [notification.id ?? ''],
                ),
              ),
            );
        onRemove?.call(
          index,
          notification,
          false,
        );
      },
      onDismissed: () {
        context.read<DeleteNotificationsBloc>().add(
              DeleteNotificationsEvent.delete(
                input: DeleteNotificationsInput(
                  ids: [notification.id ?? ''],
                ),
              ),
            );
        onRemove?.call(
          index,
          notification,
          true,
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Builder(
          builder: (context) {
            if ([
              Enum$NotificationType.event_request_created.name,
              Enum$NotificationType.event_request_approved.name,
              Enum$NotificationType.event_request_declined.name,
            ].contains(notification.type)) {
              return EventJoinRequestNotificationItem(
                notification: notification,
              );
            }

            if (notification.type ==
                Enum$NotificationType.ticket_assigned.name) {
              return EventTicketAssignedNotificationItem(
                notification: notification,
              );
            }

            if (notification.type == Enum$NotificationType.event_invite.name) {
              return EventInvitedNotificationItem(notification: notification);
            }

            if (notification.type == Enum$NotificationType.event_update.name) {
              return EventUpdateNotificationItem(notification: notification);
            }

            if ([
              Enum$NotificationType.payment_succeeded.name,
              Enum$NotificationType.payment_failed.name,
              Enum$NotificationType.payment_refunded.name,
            ].contains(notification.type)) {
              return PaymentNotificationItem(notification: notification);
            }

            if (notification.type ==
                Enum$NotificationType.user_friendship_request.name) {
              return FriendRequestNotificationItem(notification: notification);
            }

            return DefaultNotificationItem(notification: notification);
          },
        ),
      ),
    );
  }
}
