import 'package:graphql_flutter/graphql_flutter.dart';

const eventHostExpandedFragment = '''
  fragment eventHostExpandedFragment on User {
    _id
    name
    display_name
    username
    new_photos_expanded(limit: 1) {
      _id
      key
      bucket
    }
    __typename
  }
''';

final eventFragment = '''
  ${eventHostExpandedFragment}

  fragment eventFields on Event {
  _id
  title
  slug
  host
  host_expanded {
    ...eventHostExpandedFragment
  }
  new_new_photos_expanded(limit: 1) {
    key
    bucket
  }
  start
  end
  cost
  currency
  broadcasts {
    provider_id
  }
  address {
    street_1
    city
    title
    region
  }
  accepted
}
''';

final getEventsQuery = gql('''
  ${eventFragment}
  query(
    \$highlight: Boolean
    \$search: String
    \$accepted: MongoID
    \$limit: Int
    \$skip: Int
  ) {
    getEvents(
      highlight: \$highlight
      search: \$search
      accepted: \$accepted
      limit: \$limit
      skip: \$skip
    ) {
    ...eventFields
    }
  }
''');

final getHomeEventsQuery = gql('''
  ${eventFragment}
  query(
        \$tense: EventTense,
        \$latitude: Float,
        \$longitude: Float,
        \$query: String = "",
    ) {
        getHomeEvents(
            tense: \$tense,
            limit: 100,
            latitude: \$latitude,
            longitude: \$longitude,
            search: \$query,
        ) {
           ...eventFields
        }
    }
''');

final getHostingEventsQuery = gql('''
  ${eventFragment}
  query(
    \$id: MongoID!, 
    \$state: FilterEventInput, 
    \$limit: Int = 100, 
    \$skip: Int = 0, 
    \$order: Int = -1
  ) {
    events: getHostingEvents(
      user: \$id, 
      state: \$state, 
      limit: \$limit, 
      skip: \$skip, 
      order: \$order
    ) {
      ...eventFields
    }
  }
''');
