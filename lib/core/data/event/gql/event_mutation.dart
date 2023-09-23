import 'package:graphql_flutter/graphql_flutter.dart';

final acceptEventMutation = gql('''
  mutation (\$id: MongoID!) {
    acceptEvent(_id: \$id) {
      messages {
        primary
        secondary
      }
      payment {
        amount
        currency
        provider
      }
      reservation {
        active
      }
      state
    }
}
''');
