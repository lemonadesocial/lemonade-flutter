import 'package:graphql_flutter/graphql_flutter.dart';

final redeemEventTicketsMutation = gql('''
  mutation (
    \$id: MongoID!
    \$discount: String
    \$type: MongoID
    \$count: Float!
    \$address: MongoID
  ) {
    redeemEventTickets(
      event: \$id
      discount: \$discount
      type: \$type
      count: \$count
      address: \$address
    ) {
      amount
      currency
      provider_id
    }
}
''');

final acceptEventMutation = gql('''
  mutation (\$id: MongoID!, \$skip: Boolean = false) {
    acceptEvent(_id: \$id, skip_payment: \$skip) {
      messages {
        primary
        secondary
      }
      payment {
        amount
        currency
        provider
      }
      reservation {
        active
      }
      state
    }
}
''');
