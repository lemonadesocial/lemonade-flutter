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
  blocked
  blocked_expanded {
      _id,
      name,
      image_avatar,
  }
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
  handle_github
  handle_facebook
  handle_instagram
  handle_linkedin
  handle_twitter
  handle_mirror
  handle_farcaster
  handle_lens
  calendly_url
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
    notification_filters
  }
''';

const userTermFragment = '''
  fragment userTermFragment on User {
    terms_accepted_adult
    terms_accepted_conditions
  }
''';

final getMeQuery = gql('''
  $baseUserFragment
  $userProfileFragment
  $privateFragment
  $userTermFragment

  query() {
    getMe() {
      ...baseUserFragment
      ...userProfileFragment
      ...privateFragment
      ...userTermFragment
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

final deleteUserMutation = gql('''
  mutation {
    deleteUser
}
''');

final reportUserMutation = gql('''
  mutation (\$id: MongoID!, \$reason: String!, \$block: Boolean) {
    reportUser(
      input: { 
          user: \$id,
          reason: \$reason, 
          block: \$block 
      }
    )
  }
''');

final getUserFollowsQuery = gql('''
  query GetUserFollows(\$follower: MongoID, \$followee: MongoID, \$limit: Int, \$skip: Int) {
    getUserFollows(
      input: {followee: \$followee, follower: \$follower}
      limit: \$limit
      skip: \$skip
    ) {
      _id
      follower
      followee
      __typename
    }
  }
''');

final toggleBlockUserQuery = gql('''
  mutation (\$id: MongoID!, \$block: Boolean!) {
    toggleBlockUser(
      input: { 
          user: \$id,
          block: \$block 
      }
    )
  }
''');
