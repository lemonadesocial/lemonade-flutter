import 'package:graphql_flutter/graphql_flutter.dart';

final getPoapViewQuery = gql('''
  query(\$network: String!, \$address: Address!, \$name: String!) {
    poapView(network: \$network, address: \$address, name: \$name)
  }
''');
