import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/core/data/payment/payment_query.dart';

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
    speaker_users_expanded {
      ...eventHostExpandedFragment
    }
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

const eventTicketTypesFragment = '''
  fragment eventTicketTypesFragment on Event {
    required_profile_fields
    event_ticket_types {
      _id
      active
      private
      limited
      event
      title
      prices {
        cost
        currency
        network
        default
      }
      ticket_limit
      ticket_count
      default
      address_required
      description
      description_line
      external_ids
      offers {
        _id
        provider
        provider_network
        provider_id
        position
        auto
        broadcast_rooms
      }
      photos
      photos_expanded(limit: 1) {
        _id
        url
        key 
        bucket
      }
      limited_whitelist_users {
        _id
        email
      }
      category
      category_expanded {
        _id
        title
        event
        description
      }
    }
  }
''';

const eventProgramFragment = '''
  fragment eventProgramFragment on Event {
    sessions {
      _id
      title
      start
      end
      broadcast
      description
      photos
      speaker_users
      photos_expanded {
        url
      }
      speaker_users_expanded {
        ...eventHostExpandedFragment
      }
    }
  }
''';

const eventPaymentAccountFragment = '''
  $paymentAccountFragment

  fragment eventPaymentAccountFragment on Event {
    payment_accounts_new,
    payment_accounts_expanded {
      ...paymentAccountFragment
    }
  }
''';

const eventFragment = '''
  $eventHostExpandedFragment
  $eventPeopleFragment
  $eventMatrixFragment

  fragment eventFields on Event {
  _id
  title
  slug
  host
  approval_required
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
  timezone
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
  latitude
  longitude
  guest_limit
  guest_limit_per
  virtual
  private
  invited_count
  checkin_count
  attending_count
  pending_request_count
  guest_directory_enabled
  published
  rewards {
    _id
    active
    title
    icon_url
    icon_color
    limit
    limit_per
    payment_ticket_types
  }
  event_ticket_types {
    _id
    prices {
      currency
      network
      cost
    }
  }
  ...eventPeopleFragment
  ...eventMatrixFragment
}
''';

const eventApplicationFormFragment = '''
  fragment eventApplicationFormFragment on Event {
    application_profile_fields {
      field
      required
    }
    application_questions {
      _id
      question
      required
    }
    application_form_submission
  }
''';

const eventPaymentTicketsDiscountFragment = '''
  fragment eventPaymentTicketsDiscountFragment on Event {
    payment_ticket_discounts {
      active
      code
      ratio
      stamp
      ticket_count
      ticket_count_map
      ticket_limit_per
      ticket_limit
      ticket_types
      use_count
      use_count_map
      use_limit
      use_limit_per
    }
  }
''';

const eventFrequentQuestionsFragment = '''
  fragment eventFrequentQuestionsFragment on Event {
    frequent_questions {
      _id
      question
      answer
    }
  }
''';

final getEventDetailQuery = gql('''
  $eventFragment
  $eventOfferFragment
  $eventPaymentAccountFragment
  $eventTicketTypesFragment
  $eventProgramFragment
  $eventApplicationFormFragment
  $eventPaymentTicketsDiscountFragment
  $eventFrequentQuestionsFragment

  query(\$id: MongoID!) {
    getEvent(_id: \$id) {
      ...eventFields
      ...eventOfferFragment
      ...eventPaymentAccountFragment
      ...eventTicketTypesFragment
      ...eventProgramFragment
      ...eventApplicationFormFragment
      ...eventPaymentTicketsDiscountFragment
      ...eventFrequentQuestionsFragment
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
    \$skip: Int = 0
  ) {
    events: getHostingEvents(
      user: \$id, 
      state: \$state, 
      limit: \$limit, 
      skip: \$skip
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
