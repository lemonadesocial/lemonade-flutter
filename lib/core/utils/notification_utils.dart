import 'package:app/graphql/backend/schema.graphql.dart';

class NotificationUtils {
  static List<Enum$NotificationType> get eventRelatedNotificationTypes => [
        Enum$NotificationType.ticket_assigned,
        Enum$NotificationType.event_request_created,
        Enum$NotificationType.event_request_approved,
        Enum$NotificationType.event_request_declined,
        Enum$NotificationType.payment_succeeded,
        Enum$NotificationType.payment_failed,
        Enum$NotificationType.payment_refunded,
        Enum$NotificationType.event_invite,
        Enum$NotificationType.event_update,
        Enum$NotificationType.event_cancellation,
      ];
}
