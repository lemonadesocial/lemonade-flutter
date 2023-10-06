import 'package:app/core/data/user/dtos/user_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final getUserFriendShip = gql('''
query (
  \$state: UserFriendshipState
  \$other: MongoID
  \$user: MongoID
  \$type: UserFriendshipType
  \$limit: Int
  \$skip: Int
  \$other_search: String
) {
  friendships: getUserFriendships(
    input: {
      state: \$state
      other: \$other
      user: \$user
      type: \$type
      other_search: \$other_search
    }
    limit: \$limit
    skip: \$skip
  ) {
    items {
      _id
      user1
      user2
      state
      type
      other_expanded {
        ...OtherExpanded
        wallets
        __typename
      }
      __typename
    }
    __typename
  }
}

fragment OtherExpanded on User {
  _id
  name
  username
  matrix_localpart
  new_photos_expanded(limit: 1) {
    _id
    key
    bucket
    __typename
  }
  __typename
}

''');

final getUserFollowee = gql('''
  $baseUserFragment

  query (\$follower: MongoID, \$followee_search: String) {
    getUserFollows(
      input: { follower: \$follower, followee_search: \$followee_search }
    ) {
      followee_expanded {
        ...baseUserFragment
        __typename
      }
      __typename
    }
  }
''');

final getUserFollower = gql('''
   $baseUserFragment
  
  query (\$followee: MongoID, \$follower_search: String, \$limit: Int, \$skip: Int) {
  getUserFollows(
    input: { followee: \$followee, follower_search: \$follower_search }
    limit: \$limit
    skip: \$skip
  ) {
    follower_expanded {
      ...baseUserFragment
      __typename
    }
    __typename
  }
}
''');
