import 'package:graphql_flutter/graphql_flutter.dart';

final redeemTicketsMutation = gql('''
  mutation RedeemTickets(\$input: RedeemTicketsInput!) {
    redeemTickets(input: \$input) {
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
