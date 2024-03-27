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

      ... on EthereumEscrowAccount {
        address
        currencies
        currency_map
        host_refund_percent
        minimum_deposit_percent
        network
        refund_policies {
          percent
          timestamp
        }
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
    due_amount
    ref_data
    ticket_types_expanded {
      _id
      active
      event
      title
      prices {
        cost
        currency
        network
        default
      }
      default
      address_required
      description
      photos_expanded {
        _id
        bucket
        key
      }
    }
  }
''';

const paymentBaseFragment = '''
  fragment paymentBaseFragment on NewPaymentBase {
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

final getPaymentQuery = gql('''
  $paymentFragment

  query GetNewPayment(\$id: MongoID!) {
    getNewPayment(_id: \$id) {
      ...paymentFragment
    }
  }
''');
