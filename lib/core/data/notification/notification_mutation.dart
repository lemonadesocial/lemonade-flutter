import 'package:graphql_flutter/graphql_flutter.dart';

final deleteNotificationsMutation = gql('''
  mutation(\$ids: [MongoID!]) {
    deleteNotifications(_id: \$ids)
  }
''');
