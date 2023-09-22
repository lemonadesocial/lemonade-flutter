import 'package:graphql_flutter/graphql_flutter.dart';

final getEventListTicketTypesResponseQuery = gql('''
  query ListTicketTypes(\$input: ListTicketTypesInput!) {
    listTicketTypes(input: \$input) {
      discount {
        discount
        limit
        ratio
      }
      ticket_types {
        _id
        title
        cost
        active
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
  query CalculateTicketsPricing(\$input: CalculateTicketsPricingInput!) {
    calculateTicketsPricing(input: \$input) {
      currency
      discount
      subtotal
      total
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
