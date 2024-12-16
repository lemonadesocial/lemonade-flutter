import 'package:graphql_flutter/graphql_flutter.dart';

// This same as paymentAccountFragment but with different name
const paymentAccountInfoFragment = '''
  fragment paymentAccountInfoFragment on PaymentAccountInfo {
      _id
      active
      created_at
      user
      fee
      relay {
        payment_splitter_contract
      }
      type
      title
      provider
      account_info {
        ...on EthereumAccount {
        currencies
        currency_map
        address
<<<<<<< HEAD
=======
        network
>>>>>>> 5bf5172f15fe247af56fa29261ea488d17a5c0f9
      }

      ... on EthereumRelayAccount {
        address
        currencies
        currency_map
        payment_splitter_contract
      }

      ...on EthereumStakeAccount {
        currencies
        address
        currency_map
        network
        config_id
        requirement_checkin_before
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
        refund_policies {
          percent
          timestamp
        }
      }
    }
  }
''';

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
          network
        }

      ... on EthereumRelayAccount {
          address
          currencies
          currency_map
          payment_splitter_contract
        }

      ...on EthereumStakeAccount {
        currencies
        address
        currency_map
        network
        config_id
        requirement_checkin_before
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
