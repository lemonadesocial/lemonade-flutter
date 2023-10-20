import 'package:graphql_flutter/graphql_flutter.dart';

final reportPostMutation = gql('''
  mutation(\$id: MongoID!, \$reason: String!) {
    flagPost(_id: \$id, reason: \$reason)
  }
''');

final reportEventMutation = gql('''
  mutation(\$id: MongoID!, \$reason: String!) {
    flagEvent(_id: \$id, reason: \$reason)
  }
''');
