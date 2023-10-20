import 'package:graphql_flutter/graphql_flutter.dart';

final createUserFollowMutation = gql('''
  mutation (\$followee: MongoID!) {
    createUserFollow(followee: \$followee)
  }
''');

final deleteUserFollowMutation = gql('''
  mutation (\$followee: MongoID!) {
    deleteUserFollow(followee: \$followee)
  }
''');
