import 'package:graphql_flutter/graphql_flutter.dart';

final createUserFollow = gql('''
  mutation (\$followee: MongoID!) {
    createUserFollow(followee: \$followee)
  }
''');

final deleteUserFollow = gql('''
  mutation (\$followee: MongoID!) {
    deleteUserFollow(followee: \$followee)
  }
''');
