import 'package:graphql_flutter/graphql_flutter.dart';

const stripeCardFragment = '''
  fragment stripeCardFragment on StripeCard {
    _id
    active
    stamp
    provider_id
    user
    brand
    name
    last4
  }
''';

final getStripeCardsQuery = gql('''
  $stripeCardFragment

  query GetStripeCards(\$skip: Int!, \$limit: Int!) {
    getStripeCards(skip: \$skip, limit: \$limit) {
      ...stripeCardFragment
    }
  }
''');
