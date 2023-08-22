import 'package:graphql_flutter/graphql_flutter.dart';

final claimPoapMutation = gql('''
  mutation(
    \$network: String!
    \$address: Address!
    \$input: ClaimArgsInput
    \$to: Address
  ) {
    claimPoap(
      network: \$network, 
      address: \$address, 
      input: \$input, 
      to: \$to
    ) {
      _id
      network
      address
      to
      state
      args {
        claimer
        tokenURI
      }
      errorMessage
  }
}
''');
