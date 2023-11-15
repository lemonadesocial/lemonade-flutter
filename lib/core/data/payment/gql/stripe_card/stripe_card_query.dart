import 'package:graphql_flutter/graphql_flutter.dart';

const stripeCardFragment = '''
  fragment stripeCardFragment on StripeCard {
    _id
    active
    stamp
    payment_account
    provider_id
    user
    brand
    name
    last4
  }
''';

final getStripeCardsQuery = gql('''
  $stripeCardFragment

  query GetStripeCards(\$skip: Int!, \$limit: Int!, \$paymentAccount: MongoID) {
    getStripeCards(skip: \$skip, limit: \$limit, payment_account: \$paymentAccount) {
      ...stripeCardFragment
    }
  }
''');
