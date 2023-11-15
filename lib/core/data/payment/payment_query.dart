const paymentAccountFragment = '''
  fragment paymentAccountFragment on NewPaymentAccount {
      _id
      active
      created_at
      user
      type
      provider
      account_info {
        ...on EthereumAccount {
        currencies
        currency_map
        address
        network
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
