import 'package:app/core/data/payment/payment_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const eventTicketPriceFragment = '''
fragment eventTicketPriceFragment on EventTicketPrice {
  cost
  currency
  payment_accounts
  payment_accounts_expanded {
    ...paymentAccountFragment
  }
}
''';

// this one for guest
final getEventTicketTypesQuery = gql('''
  $paymentAccountFragment
  $eventTicketPriceFragment

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
        limited
        private
        whitelisted
        event
        title
        prices {
          ...eventTicketPriceFragment
        }
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
        category
        category_expanded {
          _id
          title
          description
          event
        }
      }
      limit
    }
}
''');

final calculateTicketsPricingInfoQuery = gql('''
  $paymentAccountInfoFragment

  query CalculateTicketsPricing(\$input: CalculateTicketsPricingInput!) {
    calculateTicketsPricing(input: \$input) {
      total
      subtotal
      discount
      payment_accounts {
        ...paymentAccountInfoFragment
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
      shortid
    }
  }
''');

final getTicketQuery = gql('''
  query GetTicket(\$shortid: String!) {
    getTicket(shortid: \$shortid) {
      _id
      event
      type
      accepted
      assigned_email
      assigned_to
      invited_by
      shortid
    }
  }
''');

final getEventCurrenciesQuery = gql('''
  query GetEventCurrencies(\$id: MongoID!, \$used: Boolean) {
    getEventCurrencies(_id: \$id, used: \$used) {
      currency
      decimals
      network
    }
  }
''');
