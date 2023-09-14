import 'package:graphql_flutter/graphql_flutter.dart';

const baseUserFragment = '''
  fragment baseUserFragment on User {
  _id
  name
  username
  display_name
  new_photos
  image_avatar
  wallets
  wallet_custodial
}
''';

const userProfileFragment = '''
  fragment userProfileFragment on User {
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
    }
    start
    end
    cost
    currency
    cohosts
  }
  following
  followers
  friends
  email
  company_name
  ethnicity
  new_gender
  industry
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
    }
    value
  }
  job_title
  layout_sections {
    hidden
    id
  }
  new_photos_expanded {
    _id
    key
    bucket
    type
  }
  offers {
    _id
    provider
    provider_network
    provider_id
    position
  }
  payment_direct {
    provider
    currency
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
  }
  tagline
  frequent_questions {
    _id
    question
    answer
    tag
    position
  }
}
''';

const privateFragment = '''
  fragment userPrivateFragment on User {
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
    }
    country
    currency
    date_of_birth
    discovery {
      max_age
      min_age
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
    }
    phone
    search_range
    settings
    twitch_user_info
    zoom_user_info
    lemon_amount
    music
    tag_timeline
  }
''';

final getMeQuery = gql('''
  $baseUserFragment
  query() {
    getMe() {
      ...baseUserFragment
    }
}
''');

final getUserQuery = gql('''
  $baseUserFragment
  $userProfileFragment

  query (\$id: MongoID, \$username: String, \$matrix_localpart: String) {
    getUser(_id: \$id, username: \$username, matrix_localpart: \$matrix_localpart) {
      ...baseUserFragment,
      ...userProfileFragment
    }
  }
''');

final checkValidUsernameQuery = gql('''
  query (\$username: String) {
  getUser(username: \$username) {
    active
    __typename
  }
}

''');
