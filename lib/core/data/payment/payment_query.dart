const ethereumAccountFragment = '''
  fragment ethereumAccountFragment on EthereumAccount {
    currencies
    currency_map
    address
    network
  }
''';

const stripeAccountFragment = '''
  fragment stripeAccountFragment on StripeAccount {
    currencies
    currency_map
    account_id
    publishable_key
  }
''';

const digitalAccountFragment = '''
  fragment digitalAccountFragment on DigitalAccount {
    currencies
    currency_map
    account_id
  }
''';

const accountInfoFragment = '''
  $ethereumAccountFragment
  $stripeAccountFragment
  $digitalAccountFragment
  
  fragment accountInfoFragment on AccountInfo {
  ...on EthereumAccount {
    ...ethereumAccountFragment
  }

  ...on StripeAccount {
    ...stripeAccountFragment
  }

  ...on DigitalAccount {
    ...digitalAccountFragment
  }
}
''';

const paymentAccountFragment = '''
  $accountInfoFragment

  fragment paymentAccountFragment on NewPaymentAccount {
    _id
    active
    created_at
    user
    type
    provider
    account_info {
      ...accountInfoFragment
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
