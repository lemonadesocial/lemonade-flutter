import 'package:graphql_flutter/graphql_flutter.dart';

final getUserWalletRequestQuery = gql(''' 
  query getUserWalletRequest(\$wallet: String!) {
    getUserWalletRequest(wallet: \$wallet) {
      message
      token
    }
  }
''');
