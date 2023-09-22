import 'package:graphql_flutter/graphql_flutter.dart';

final acceptEventMutation = gql('''
  mutation (\$id: MongoID!, \$skip: Boolean = false) {
    acceptEvent(_id: \$id, skip_payment: \$skip) {
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
