import 'package:graphql_flutter/graphql_flutter.dart';

final getChainsListQuery = gql('''
  query ListChains {
    listChains {
      active
      chain_id
      name
      rpc_url
      logo_url
      block_time
      safe_confirmations
      tokens {
        active
        name
        symbol
        decimals
        contract
        logo_url
      }
      relay_payment_contract
    }
  }
''');
