import 'package:app/core/data/event/gql/event_tickets_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/core/data/payment/payment_query.dart';

const eventAddressFragment = '''
  fragment eventAddressFragment on Address {
    _id
    street_1
    street_2
    city
    title
    region
    postal
    country
    title
    latitude
    longitude
    recipient_name
    additional_directions
  }
''';

const eventHostExpandedFragment = '''
  fragment eventHostExpandedFragment on User {
    _id
    name
    display_name
    username
    image_avatar
    new_photos_expanded(limit: 1) {
      _id
      key
      bucket
    }
    job_title
    __typename
    matrix_localpart
  }
''';

const eventPeopleFragment = '''
  fragment eventPeopleFragment on Event {
    cohosts
    visible_cohosts
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
  $eventTicketPriceFragment

  fragment eventTicketTypesFragment on Event {
    event_ticket_types {
      _id
      active
      private
      limited
      event
      title
      prices {
        ...eventTicketPriceFragment
      }
      ticket_limit_per
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
  fragment eventPaymentAccountFragment on Event {
    payment_accounts_new,
    payment_accounts_expanded {
      ...paymentAccountFragment
    }
  }
''';

const eventFragment = '''
  $eventHostExpandedFragment
  $eventAddressFragment
  $eventPeopleFragment
  $eventMatrixFragment

  fragment eventFields on Event {
    _id
    shortid
    title
    slug
    host
    approval_required
    hide_cohosts
    host_expanded {
      ...eventHostExpandedFragment
    }
    cohosts_expanded(limit: 25) {
      ...eventHostExpandedFragment
    }
    visible_cohosts_expanded(limit: 25) {
      ...eventHostExpandedFragment
    }
    new_new_photos
    new_new_photos_expanded(limit: 25) {
      _id
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
      ...eventAddressFragment
    }
    latitude
    longitude
    guest_limit
    guest_limit_per
    virtual
    virtual_url
    url
    private
    invited_count
    checkin_count
    attending_count
    pending_request_count
    ticket_count
    guest_directory_enabled
    published
    address_directions
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
      default
      prices {
        currency
        cost
        default
      }
    }
    tags
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
      position
      type
      select_type
      options
    }
    application_form_submission
    registration_disabled
    rsvp_wallet_platforms {
      platform
      required
    }
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

const eventTicketsFragment = '''
  fragment eventTicketsFragment on Event {
    tickets {
      _id
      event
      type
      accepted
      assigned_email
      assigned_to
      invited_by
    }
  }
''';

const eventSubEventFragment = '''
  fragment eventSubEventFragment on Event {
    subevent_enabled
    subevent_parent
    subevent_parent_expanded {
      _id
      title
      new_new_photos_expanded(limit: 1) {
        _id
        key
        bucket
      }
    }
    subevent_settings {
      ticket_required_for_creation
      ticket_required_for_purchase
    }
    inherited_cohosts
  }
''';

const eventSpaceFragment = '''
  fragment eventSpaceFragment on Event {
    space
    space_expanded {
      _id
      title
      description
      handle_twitter
      handle_instagram
      handle_youtube
      handle_tiktok
      handle_linkedin
      website
      personal
      image_avatar_expanded {
       _id
        url
      }
    }
  }
''';

final getEventDetailQuery = gql('''
  $paymentAccountFragment
  $eventFragment
  $eventOfferFragment
  $eventPaymentAccountFragment
  $eventTicketTypesFragment
  $eventProgramFragment
  $eventApplicationFormFragment
  $eventPaymentTicketsDiscountFragment
  $eventFrequentQuestionsFragment
  $eventTicketsFragment
  $eventSubEventFragment
  $eventSpaceFragment

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
      ...eventTicketsFragment
      ...eventSubEventFragment
      ...eventSpaceFragment
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
        \$skip: Int,
        \$limit: Int
    ) {
        getHomeEvents(
            tense: \$tense,
            limit: \$limit,
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
  query GetHostingEvents(
    \$id: MongoID!, 
    \$state: FilterEventInput, 
    \$limit: Int = 100, 
    \$skip: Int = 0,
    \$draft: Boolean
  ) {
    getHostingEvents(
      user: \$id, 
      state: \$state, 
      limit: \$limit, 
      skip: \$skip,
      draft: \$draft
    ) {
      ...eventFields
    }
  }
''');

final getUpcomingEventsQuery = gql('''
  $eventFragment
  query GetUpcomingEvents(
    \$id: MongoID!, 
    \$limit: Int = 100, 
    \$skip: Int = 0, 
    \$host: Boolean
    \$sort: JSON
  ) {
    getUpcomingEvents(user: \$id, limit: \$limit, skip: \$skip, host: \$host, sort: \$sort) {
      ...eventFields
    }
  }
''');

final getPastEventsQuery = gql('''
  $eventFragment
  query (\$id: MongoID!, \$limit: Int = 100, \$skip: Int = 0, \$sort: JSON, \$hosting_only: Boolean) {
  events: getPastEvents(user: \$id, limit: \$limit, skip: \$skip, hosting_only: \$hosting_only, sort: \$sort) {
    ...eventFields
  }
}
''');
