const eventJoinRequestFragment = '''
  fragment eventJoinRequestFragment on EventJoinRequest {
  _id
  created_at
  approved_at
  declined_at
  user
  declined_by
  approved_by
  user_expanded {
    _id
    display_name
    image_avatar
    username
    wallets
  }
  approved_by_expanded {
    _id
    display_name
    image_avatar
    username
    wallets
  }
  declined_by_expanded {
    _id
    display_name
    image_avatar
    username
    wallets
  }
  payment_expanded {
    _id
    amount
    currency
    state
  }
  ticket_info {
    count
    ticket_type
  }
  event_expanded {
    _id
  }
}
''';
