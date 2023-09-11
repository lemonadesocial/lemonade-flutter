import 'package:graphql_flutter/graphql_flutter.dart';

final claimModified = gql('''
  subscription claimModified {
    claimModified {
      to
      network
      state
      errorDescription
      errorMessage
      address
      tokenId
      chainlinkRequest {
        fulfilled
      }
      args {
        tokenURI
      }
    }
  }
''');

final transferModified = gql('''
  subscription transferModified {
    transferModified {
      to
      network
      state
      errorMessage
      address
      tokenId
      args {
        to
        tokenId
      }
    }
  }
''');
