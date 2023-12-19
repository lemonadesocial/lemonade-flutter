import 'package:graphql_flutter/graphql_flutter.dart';

final getInitSafeTransactionQuery = gql('''
  query GetInitSafeTransaction(\$input: GetInitSafeTransactionInput!) {
    getInitSafeTransaction(input: \$input) {
      to
      value
      data
    }
  }
''');

final getSafeFreeLimitQuery = gql('''
  query GetSafeFreeLimit(\$network: String!) {
    getSafeFreeLimit(network: \$network) {
      current
      max
    }
  }
''');
