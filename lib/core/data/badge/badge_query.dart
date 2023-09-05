import 'package:app/core/data/user/dtos/user_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const badgeListFragment = '''
  $baseUserFragment

  fragment badgeListFragment on BadgeList {
    _id
    image_url
    title
    user
    user_expanded {
      ...baseUserFragment
      __typename
    }
    __typename
  }
''';

final getBadgesQuery = gql('''
  $badgeListFragment

  query (
  \$skip: Int!
  \$limit: Int!
  \$list: [MongoID!]
  \$city: String
  \$country: String
  \$distance: Float
  \$id: [MongoID!]
) {
  getBadges(
    skip: \$skip
    limit: \$limit
    list: \$list
    city: \$city
    country: \$country
    distance: \$distance
    _id: \$id
  ) {
    _id
    city
    claimable
    country
    contract
    distance
    list
    list_expanded {
      ...badgeListFragment
    }
    network
    __typename
  }
}
''');

final getBadgeListsQuery = gql('''
  $badgeListFragment

  query (
  \$skip: Int!
  \$limit: Int!
  \$user: MongoID
  \$title: String
) {
  getBadgeLists(
    skip: \$skip
    limit: \$limit
    user: \$user
    title: \$title
  ) {
    ...badgeListFragment
  }
}
''');

final getBadgeCitiesQuery = gql('''
  query (\$skip: Int!, \$limit: Int!) {
  getBadgeCities(skip: \$skip, limit: \$limit) {
    city
    country
    __typename
  }
}
''');
