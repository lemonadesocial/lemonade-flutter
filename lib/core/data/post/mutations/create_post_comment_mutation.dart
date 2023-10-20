import 'package:graphql_flutter/graphql_flutter.dart';

final createPostCommentMutation = gql('''
  mutation (\$text: String!, \$post: MongoID!) {
    createComment(input: {text: \$text, post: \$post}) {
      _id
      created_at
      user
      text
      post
      user
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
