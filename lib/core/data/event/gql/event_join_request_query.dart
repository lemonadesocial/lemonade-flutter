const eventJoinRequestFragment = '''
  fragment eventJoinRequestFragment on EventJoinRequest {
  _id
  created_at
  user
  decided_at
  decided_by
  decided_by_expanded {
    _id
    display_name
    image_avatar
    username
    wallets
    email
  }
  user_expanded {
    _id
    display_name
    image_avatar
    username
    wallets
  }
  ticket_info {
    count
    ticket_type
  }
  event_expanded {
    _id
  }
  state
}
''';
