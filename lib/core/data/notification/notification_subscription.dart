import 'package:app/core/data/notification/notification_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final watchNotificationSubscription = gql('''
  $notificationFragment

  subscription NotificationCreated {
    notificationCreated {
      ...notificationFragment
    }
  }
''');
