import 'package:graphql_flutter/graphql_flutter.dart';

const postFragment = ''' 
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
      _id
      name
      new_photos_expanded(limit: 1) {
        _id
        key
        bucket
      }
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
  ${postFragment}
  
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
