import 'package:graphql_flutter/graphql_flutter.dart';

final addUserFcmTokenMutation = gql('''
  mutation AddUserFcmToken(\$token: String!) {
    addUserFcmToken(token: \$token)
  }
''');


final removeUserFcmTokenMutation = gql('''
  mutation RemoveUserFcmToken(\$token: String!) {
    removeUserFcmToken(token: \$token)
  }
''');

