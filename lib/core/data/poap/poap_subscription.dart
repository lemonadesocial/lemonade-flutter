import 'package:graphql_flutter/graphql_flutter.dart';

final claimModifiedSubscription = gql('''
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

final transferModifiedSubscription = gql('''
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
