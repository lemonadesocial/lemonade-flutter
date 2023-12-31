import 'package:graphql_flutter/graphql_flutter.dart';

const paymentAccountFragment = '''
  fragment paymentAccountFragment on NewPaymentAccount {
      _id
      active
      created_at
      user
      type
      title
      provider
      account_info {
        ...on EthereumAccount {
        currencies
        currency_map
        address
        networks
      }

      ...on StripeAccount {
        currencies
        currency_map
        account_id
        publishable_key
      }

      ...on DigitalAccount {
        currencies
        currency_map
        account_id
      }

      ... on SafeAccount {
          currencies
          currency_map
          address
          network
          owners
          threshold
          pending
        }
    }
  }
''';

const paymentFragment = '''
  $paymentAccountFragment

  fragment paymentFragment on NewPayment {
    _id
    stamps
    amount
    currency
    state
    user
    billing_info {
      _id
      email
      firstname
      lastname
    }
    transfer_metadata
    transfer_params
    failure_reason
    account_expanded {
      ...paymentAccountFragment
    }
  }
''';

final getPaymentAccountsQuery = gql('''
  $paymentAccountFragment

  query ListNewPaymentAccounts(
    \$skip: Int!
    \$limit: Int!
    \$id: [MongoID!]
    \$type: PaymentAccountType
    \$provider: NewPaymentProvider
  ) {
    listNewPaymentAccounts(
      skip: \$skip
      limit: \$limit
      _id: \$id
      type: \$type
      provider: \$provider
    ) {
      ...paymentAccountFragment
    }
  }
''');
