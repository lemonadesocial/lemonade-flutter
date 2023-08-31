import 'package:app/core/data/event/event_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const postFragment = '''
  $eventHostExpandedFragment

  fragment postFragment on Post {
  _id
  created_at
  user
  visibility
  text
  reactions
  ref_type
  ref_id
  comments
  user_expanded {
    _id
    name
    username
    new_photos_expanded(limit: 1) {
      _id
      key
      bucket
    }
  }
  ref_event {
    _id
    title
    host
    new_new_photos_expanded(limit: 1) {
      key
      bucket
    }
    start
    end
    cost
    currency
    host
    host_expanded {
      ...eventHostExpandedFragment
    }
    cohosts_expanded(limit: 3) {
      ...eventHostExpandedFragment
    }
    slug
    latitude
    longitude
    address {
      street_1
      city
      title
      region
    }
  }
  ref_file {
    _id
    key
    bucket
  }
  has_reaction
  published
}

''';

final getPostsQuery = gql('''
  $postFragment
  
  query(
  \$id: MongoID
  \$user: MongoID
  \$published: Boolean
  \$created_at: GetPostsCreatedAtInput
  \$limit: Int
  \$skip: Int
) {
  getPosts(
    input: {
      _id: \$id
      user: \$user
      published: \$published
      created_at: \$created_at
    }
    skip: \$skip
    limit: \$limit
  ) {
    ...postFragment
  }
}
''');

final getNewsfeedQuery = gql('''
  $postFragment
  
  query(
  \$offset: Float
) {
  getNewsfeed(
    offset: \$offset
  ) {
    offset
    posts {
      ...postFragment
    }
  }
}
''');

final createPostQuery = gql('''
  $postFragment
  
  mutation (\$visibility: PostVisibility!, \$text: String, \$ref_type: PostRefType, \$ref_id: String) {
  createPost(
    input: {visibility: \$visibility, text: \$text, ref_type: \$ref_type, ref_id: \$ref_id}
  ) {
    ...postFragment
    __typename
  }
}
''');
