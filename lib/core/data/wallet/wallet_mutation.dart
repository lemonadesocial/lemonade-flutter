import 'package:graphql_flutter/graphql_flutter.dart';

final setUserWalletMutation = gql('''
  mutation SetUserWallet(\$signature: String!, \$token: String!) {
    setUserWallet(signature: \$signature, token: \$token)
  }
''');
