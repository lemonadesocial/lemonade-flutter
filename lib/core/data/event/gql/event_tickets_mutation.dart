import 'package:app/core/data/payment/payment_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final redeemTicketsMutation = gql('''
  mutation RedeemTickets(\$input: RedeemTicketsInput!) {
    redeemTickets(input: \$input) {
      tickets {
        _id
        event
        type
        accepted
        assigned_email
        assigned_to
        invited_by
      }
    }
  }
''');

final assignTicketsMutation = gql('''
  mutation AssignTickets(\$input: AssignTicketsInput!) {
    assignTickets(input: \$input)
  }
''');

final buyTicketsMutation = gql('''
  $paymentFragment
  mutation BuyTickets(\$input: BuyTicketsInput!) {
    buyTickets(input: \$input) {
      payment {
        ...paymentFragment
      }
    }
  }
''');
