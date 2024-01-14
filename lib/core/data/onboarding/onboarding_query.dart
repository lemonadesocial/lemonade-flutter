import 'package:app/core/data/user/dtos/user_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const listingFragment = '''
fragment listingFragment on User {
  _id
  name
  username
  new_photos
  image_avatar
  __typename
}
''';

const profileFragment = '''
fragment profileFragment on User {
  created_at
  display_name
  first_name
  last_name
  matrix_localpart
  attended
  company_name
  cover
  cover_expanded {
    _id
    key
    bucket
    type
    __typename
  }
  description
  education_title
  events
  events_expanded {
    _id
    title
    host
    new_new_photos_expanded(limit: 1) {
      key
      bucket
      __typename
    }
    start
    end
    cost
    currency
    cohosts
    __typename
  }
  following
  followers
  friends
  handle_facebook
  handle_instagram
  handle_linkedin
  handle_twitter
  hosted
  icebreakers {
    _id
    question
    question_expanded {
      _id
      description
      title
      __typename
    }
    value
    __typename
  }
  job_title
  layout_sections {
    hidden
    id
    __typename
  }
  new_photos_expanded {
    _id
    key
    bucket
    type
    __typename
  }
  offers {
    _id
    provider
    provider_network
    provider_id
    position
    __typename
  }
  pronoun
  tag_verified
  url_go
  wallets
  wallet_custodial
  addresses {
    recipient_name
    street_1
    street_2
    city
    region
    country
    longitude
    latitude
    title
    postal
    _id
    __typename
  }
  tagline
  frequent_questions {
    _id
    question
    answer
    tag
    position
    __typename
  }
  __typename
}
''';

const privateFragment = '''
fragment privateFragment on User {
  active
  age
  company_address {
    city
    latitude
    country
    longitude
    phone
    postal
    recipient_name
    region
    street_1
    street_2
    title
    __typename
  }
  country
  currency
  date_of_birth
  discovery {
    max_age
    min_age
    __typename
  }
  email
  ethnicity
  google_user_info
  shopify_user_info
  discord_user_info
  industry
  interests
  languages
  location_line
  new_gender
  payment_verification {
    state
    __typename
  }
  phone
  search_range
  settings
  twitch_user_info
  zoom_user_info
  lemon_amount
  music
  tag_timeline
  data
  __typename
}
''';

final updateUserProfileQuery = gql('''
  $listingFragment
  $profileFragment
  $privateFragment
  $userTermFragment

  mutation (
  \$currency: String
  \$date_of_birth: DateTimeISO
  \$description: String
  \$phone: String
  \$name: String
  \$display_name: String
  \$new_photos: [MongoID!]
  \$settings: JSON
  \$timezone: String
  \$username: String
  \$addresses: [AddressInput!]
  \$job_title: String
  \$education_title: String
  \$company_name: String
  \$company_address: AddressInput
  \$industry: String
  \$search_range: Float
  \$languages: [String!]
  \$discovery: UserDiscoverySettingsInput
  \$icebreakers: [UserIcebreakerInput!]
  \$handle_facebook: String
  \$handle_instagram: String
  \$handle_linkedin: String
  \$handle_twitter: String
  \$pronoun: String
  \$new_gender: String
  \$ethnicity: String
  \$events: [MongoID!]
  \$offers: [UserOfferInput!]
  \$layout_sections: [LayoutSectionInput!]
  \$cover: MongoID
  \$tagline: String
  \$music: [String!]
  \$data: JSON
  \$notification_filters: [JSON!]
  \$terms_accepted_adult: Boolean
  \$terms_accepted_conditions: Boolean
) {
  updateUser(
    input: {
      currency: \$currency
      date_of_birth: \$date_of_birth
      description: \$description
      phone: \$phone
      name: \$name
      display_name: \$display_name
      new_photos: \$new_photos
      settings: \$settings
      timezone: \$timezone
      username: \$username
      addresses: \$addresses
      job_title: \$job_title
      education_title: \$education_title
      company_name: \$company_name
      company_address: \$company_address
      industry: \$industry
      search_range: \$search_range
      languages: \$languages
      discovery: \$discovery
      icebreakers: \$icebreakers
      handle_facebook: \$handle_facebook
      handle_instagram: \$handle_instagram
      handle_linkedin: \$handle_linkedin
      handle_twitter: \$handle_twitter
      pronoun: \$pronoun
      new_gender: \$new_gender
      ethnicity: \$ethnicity
      events: \$events
      offers: \$offers
      layout_sections: \$layout_sections
      cover: \$cover
      tagline: \$tagline
      music: \$music
      data: \$data
      notification_filters: \$notification_filters
      terms_accepted_adult: \$terms_accepted_adult
      terms_accepted_conditions: \$terms_accepted_conditions
    }
  ) {
    ...listingFragment
    ...profileFragment
    ...privateFragment
    ...userTermFragment
    __typename
  }
}
''');
