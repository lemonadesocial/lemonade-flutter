const eventJoinRequestFragment = '''
  fragment userResponseFragment on UserResponse {
    _id
    display_name
    image_avatar
    username
    wallets
  }

  fragment eventJoinRequestFragment on EventJoinRequestBase {
    id: _id
    created_at
    approved_at
    declined_at
    user {
      ...userResponseFragment
    }
    declined_by {
      ...userResponseFragment
    }
    approved_by {
      ...userResponseFragment
    }
    payment {
      _id
      amount
      currency
      state
    }
    ticket_info {
      count
      ticket_type
    }
    event {
      id: _id
    }
  }
''';
