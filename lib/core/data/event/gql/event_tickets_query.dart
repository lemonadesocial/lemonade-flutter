import 'package:graphql_flutter/graphql_flutter.dart';

final getEventListTicketTypes = gql('''
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
