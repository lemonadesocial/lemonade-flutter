import 'package:app/core/data/payment/gql/stripe_card/stripe_card_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final createStripeCardMutation = gql('''
  $stripeCardFragment

  mutation CreateStripeCard(\$paymentMethod: String!) {
    createStripeCard(payment_method: \$paymentMethod) {
      ...stripeCardFragment
    }
}
''');
