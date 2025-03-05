import 'package:app/core/data/payment/payment_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final updatePaymentMutation = gql('''
  $paymentFragment

  mutation UpdatePayment(\$input: UpdatePaymentInput!) {
    updatePayment(input: \$input) {
      ...paymentFragment
    }
}
''');

final createPaymentAccountMutation = gql('''
  $paymentAccountFragment

  mutation CreateNewPaymentAccount(\$input: CreateNewPaymentAccountInput!) {
    createNewPaymentAccount(input: \$input) {
      ...paymentAccountFragment
    }
  }
''');

final updatePaymentAccountMutation = gql('''
  $paymentAccountFragment

  mutation UpdateNewPaymentAccount(\$input: UpdateNewPaymentAccountInput!) {
    updateNewPaymentAccount(input: \$input) {
      ...paymentAccountFragment
    }
  }
''');
