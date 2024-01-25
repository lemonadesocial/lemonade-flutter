const eventJoinRequestFragment = '''
  fragment eventJoinRequestFragment on EventJoinRequestBase {
    id: _id
    created_at
    approved_at
    declined_at
    user
    declined_by
    approved_by
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
    event
  }
''';
