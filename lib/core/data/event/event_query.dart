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
    job_title
    __typename
  }
''';

const eventFragment = '''
  $eventHostExpandedFragment

  fragment eventFields on Event {
  _id
  title
  slug
  host
  host_expanded {
    ...eventHostExpandedFragment
  }
  cohosts_expanded(limit: 25) {
    ...eventHostExpandedFragment
  }
  new_new_photos_expanded(limit: 25) {
    key
    bucket
  }
  start
  end
  cost
  cohosts
  speaker_users
  currency
  description
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
  latitude
  longitude
}
''';

final getEventDetailQuery = gql('''
  $eventFragment

  query(\$id: MongoID!) {
    getEvent(_id: \$id) {
      ...eventFields
    }
  }
''');

final getEventsQuery = gql('''
  $eventFragment
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
  $eventFragment
  query(
        \$tense: EventTense,
        \$latitude: Float,
        \$longitude: Float,
        \$query: String = "",
        \$skip: Int
    ) {
        getHomeEvents(
            tense: \$tense,
            limit: 100,
            latitude: \$latitude,
            longitude: \$longitude,
            search: \$query,
            skip: \$skip
        ) {
           ...eventFields
        }
    }
''');

final getHostingEventsQuery = gql('''
  $eventFragment
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

final getEventTicketPricingQuery = gql('''
  query GetEventTicketPricing(\$event: MongoID!, \$type: MongoID) {
    getEventTicketPricing(event: \$event, type: \$type) {
      amount
      currency
      limit
    }
  }
''');
