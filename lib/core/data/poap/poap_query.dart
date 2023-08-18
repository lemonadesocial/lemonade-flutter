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
