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

const eventPeopleFragment = '''
  fragment eventPeopleFragment on Event {
    cohosts
    speaker_users
    accepted
    invited
    pending
  }
''';

const eventMatrixFragment = '''
  fragment eventMatrixFragment on Event {
    matrix_event_room_id
  }
''';

const eventOfferFragment = '''
  fragment eventOfferFragment on Event {
    offers {
      _id
      auto
      broadcast_rooms
      position
      provider
      provider_id
      provider_network 
    }
  }
''';

const eventFragment = '''
  $eventHostExpandedFragment
  $eventPeopleFragment
  $eventMatrixFragment
  $eventOfferFragment

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
  ...eventPeopleFragment
  ...eventMatrixFragment
  ...eventOfferFragment
  start
  end
  cost
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
  payment_ticket_types {
      _id
      title
      cost
      description
    }
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

final getUpcomingEventsQuery = gql('''
  query (\$id: MongoID!, \$limit: Int = 100, \$skip: Int = 0) {
  events: getUpcomingEvents(user: \$id, limit: \$limit, skip: \$skip) {
    _id
    title
    slug
    host
    host_expanded {
      _id
      name
      new_photos_expanded {
        _id
        key
        bucket
      }
    }
    new_new_photos_expanded(limit: 1) {
      _id
      key
      bucket
    }
    start
    end
    address {
      street_1
      city
      title
      region
    }
  }
}
''');

final getPastEventsQuery = gql('''
  query (\$id: MongoID!, \$limit: Int = 100, \$skip: Int = 0) {
  events: getPastEvents(user: \$id, limit: \$limit, skip: \$skip) {
    _id
    title
    slug
    host
    host_expanded {
      _id
      name
      new_photos_expanded {
        _id
        key
        bucket
      }
    }
    new_new_photos_expanded(limit: 1) {
      _id
      key
      bucket
    }
    start
    end
    address {
      street_1
      city
      title
      region
    }
  }
}
''');
