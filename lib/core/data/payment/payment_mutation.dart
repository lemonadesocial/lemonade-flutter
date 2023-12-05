import 'package:app/core/data/payment/payment_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final updatePaymentMutation = gql('''
  $paymentFragment

  mutation UpdatePayment(\$input: UpdatePaymentInput!) {
    updatePayment(input: \$input) {
      ...paymentFragment
    }
}
''');

final createPaymentAccountMutation = gql('''
  mutation CreateNewPaymentAccount(\$input: CreateNewPaymentAccountInput!) {
    createNewPaymentAccount(input: \$input) {
      _id
      active
      created_at
      user
      provider
      title
      type
      account_info {
          ... on SafeAccount {
          currencies
          currency_map
          network
          address
          owners
          threshold
          funded
        }
        ... on EthereumAccount {
          networks
          currency_map
          address
          currencies
        }
        ... on StripeAccount {
          currencies
          currency_map
          account_id
          publishable_key
        }
      }
    }
  }
''');
