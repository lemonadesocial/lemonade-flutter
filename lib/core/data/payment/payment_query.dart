const ethereumAccountFragment = '''
  fragment ethereumAccountFragment on EthereumAccount {
    currencies
    currency_map
    address
    network
  }
''';

const safeAccountFragment = '''
  fragment safeAccountFragment on SafeAccount {
    currencies
    currency_map
    address
    network
    owners
    threshold
    funded
  }
''';

const digitalAccount = '''
  fragment digitalAccountFragment on DigitalAccount {
    currencies
    currency_map
    account_id
  }
''';

const stripAccountFragment = '''
  fragment stripeAccountFragment on StripeAccount {
    currencies
    currency_map
    account_id
    publishable_key
  }
''';

const accountInfoFragment = '''
  $ethereumAccountFragment
  $safeAccountFragment
  $digitalAccount
  $stripAccountFragment
  
  fragment accountInfo on AccountInfo{
    ...ethereumAccountFragment
    ...safeAccountFragment
    ...digitalAccount
    ...stripAccountFragment
  }
''';

const paymentAccountFragment = '''
  $accountInfoFragment

  fragment paymentAccounts on NewPaymentAccount{
    _id
    active
    created_at
    user
    type
    provider
    ...accountInfo
  }
''';