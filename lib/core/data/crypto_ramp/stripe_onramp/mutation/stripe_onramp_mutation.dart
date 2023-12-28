import 'package:graphql_flutter/graphql_flutter.dart';

final createStripeOnrampSessionMutation = gql('''
  mutation CreateStripeOnrampSession(\$input: CreateStripeOnrampSessionInput!) {
    createStripeOnrampSession(input: \$input) {
      client_secret
      publishable_key
    }
  }
''');
