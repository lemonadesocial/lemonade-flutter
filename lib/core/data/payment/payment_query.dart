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

const accountInfoFragment = '''
  $ethereumAccountFragment
  $stripeAccountFragment
  
  fragment accountInfoFragment on AccountInfo {
  ...on EthereumAccount {
    ...ethereumAccountFragment
  }

  ...on StripeAccount {
    ...stripeAccountFragment
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
