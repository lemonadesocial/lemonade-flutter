import 'package:app/core/data/event/gql/event_join_request_query.dart';
import 'package:app/core/data/payment/payment_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final redeemTicketsMutation = gql('''
  $eventJoinRequestFragment
  mutation RedeemTickets(\$input: RedeemTicketsInput!) {
    redeemTickets(input: \$input) {
      event_join_request {
        ...eventJoinRequestFragment
      }
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
  $eventJoinRequestFragment
  $paymentFragment
  mutation BuyTickets(\$input: BuyTicketsInput!) {
    buyTickets(input: \$input) {
      event_join_request {
        ...eventJoinRequestFragment
      }
      payment {
        ...paymentFragment
      }
    }
  }
''');
