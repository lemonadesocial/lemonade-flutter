import 'package:app/core/data/payment/payment_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final getEventTicketTypesQuery = gql('''
  query getEventTicketTypes(\$input: GetEventTicketTypesInput!) {
    getEventTicketTypes(input: \$input) {
      discount {
        discount
        limit
        ratio
      }
      ticket_types {
        _id
        active
        event
        title
        prices
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
        discountable
        limit
      }
      limit
    }
}
''');

final calculateTicketsPricingInfoQuery = gql('''
  $paymentAccountFragment

  query CalculateTicketsPricing(\$input: CalculateTicketsPricingInput!) {
    calculateTicketsPricing(input: \$input) {
      currency
      total
      subtotal
      discount
      payment_accounts {
        ...paymentAccountFragment
      }
    }
  }
''');

final getTicketsQuery = gql('''
  query GetTickets(
    \$skip: Int!
    \$limit: Int!
    \$id: [MongoID!]
    \$event: MongoID
    \$user: MongoID
  ) {
    getTickets(skip: \$skip, limit: \$limit, _id: \$id, event: \$event, user: \$user) {
      _id
      event
      type
      accepted
      assigned_email
      assigned_to
      invited_by
    }
  }
''');

final getListCardQuery = gql('''
  query GetStripeCards(\$skip: Int!, \$limit: Int!, \$provider: PaymentProvider){
    getStripeCards(skip: \$skip, limit: \$limit, provider: \$provider) {
      _id
      active
      stamp
      provider
      provider_id
      user
      brand
      name
      last4
    }
  }
''');

final createNewCardMutation = gql('''
  mutation CreateStripeCard(\$payment_account: MongoID!, \$payment_method: String!) {
    createStripeCard(
      payment_account: \$payment_account
      payment_method: \$payment_method
    ) {
      _id
      active
      stamp
      payment_account
      provider_id
      user
      brand
      name
      last4
    }
  }

''');
