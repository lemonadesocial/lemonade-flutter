import 'package:graphql_flutter/graphql_flutter.dart';

final getPostCommentsQuery = gql('''
  query GetComments(\$post: MongoID!, \$skip: Int, \$limit: Int) {
    getComments(input: {post: \$post}, skip: \$skip, limit: \$limit) {
      _id
      created_at
      user
      text
      post      
      user_expanded {
        _id
        name
        new_photos_expanded(limit: 1) {
          _id
          key
          bucket
          __typename
        }
        __typename
      }
      __typename
    }
}
''');
