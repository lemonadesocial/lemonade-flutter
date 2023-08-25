import 'package:graphql_flutter/graphql_flutter.dart';

final notificationFragment = '''
  fragment notificationField on Notification {
    _id
    message
    type
    created_at
    from
    from_expanded {
      _id
      new_photos_expanded(limit: 1) {
        _id
        key
        bucket
        __typename
      }
      __typename
    }
    is_seen
    __typename
  }
''';

final getNotificationsQuery = gql('''
  ${notificationFragment}
  query(
    \$skip: Int = 0
    \$limit: Int = 50
    \$type: NotificationTypeFilterInput = {nin: [payment_authorized, payment_failed, payments_wired_summary, admin_payment_verification, payments_captured_summary]}
  ) {
    getNotifications(
      skip: \$skip, 
      limit: \$limit, 
      type: \$type
    ) {
      ...notificationField
    }
  }
''');
