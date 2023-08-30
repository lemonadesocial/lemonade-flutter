import 'package:graphql_flutter/graphql_flutter.dart';

final getPoapViewQuery = gql('''
  query(\$network: String!, \$address: Address!, \$name: String!) {
    poapView(network: \$network, address: \$address, name: \$name)
  }
''');

final checkHasClaimedPoapQuery = gql('''
  query(
    \$network: String!, 
    \$address: Address!, 
    \$name: String!, 
    \$args: [JSON!]
  ) {
    poapView(
      network: \$network, 
      address: \$address, 
      name: \$name, 
      args: \$args
    )
  }
''');

final getPoapPolicyQuery = gql('''
  query(
      \$network: String!, 
      \$address: Address!, 
      \$target: Address
    ) {
      getPolicy(
        network: \$network,
        address: \$address, 
        target: \$target
      ) {
        _id
        network
        address
        node
        result {
          boolean
          node
          errors {
            message
            path
          }
        }
      }
    }
''');
