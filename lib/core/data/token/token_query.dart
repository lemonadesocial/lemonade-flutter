import 'package:graphql_flutter/graphql_flutter.dart';

final getTokensQuery = gql(''' 
  query getTokens(
  \$owner: String
  \$owner_in: [String!]
  \$tokenId: String
  \$contract: String
  \$skip: Int
  \$limit: Int
  \$id: String
  \$id_in: [String!]
  \$creator: String
  \$network: String
) {
  tokens: getTokens(
    owner: \$owner
    owner_in: \$owner_in
    tokenId: \$tokenId
    contract: \$contract
    skip: \$skip
    limit: \$limit
    id: \$id
    id_in: \$id_in
    creator: \$creator
    network: \$network
  ) {
    id
    contract
    tokenId
    uri
    creator
    metadata
    network
    royalties {
      account
      value
      __typename
    }
    registry {
      supportsLemonadePoapV1
      __typename
    }
    owner
    ownerExpanded {
      name
      image_avatar
      username
      _id
      __typename
    }
    __typename
  }
}
''');

final getTokenQuery = gql('''
  query(\$id: String!, \$network: String) {
    getToken(id: \$id, network: \$network) {
      id
      tokenId
      contract
      metadata
      network
    }
  }
''');

final tokensQuery = gql('''
  query tokens(\$limit: Int, \$skip: Int, \$sample: Int, \$where: TokenWhereComplex) {
  tokens(limit: \$limit, skip: \$skip, sample: \$sample, where: \$where) {
    id
    contract
    tokenId
    uri
    creator
    creatorExpanded {
      _id
      name
      username
      image_avatar
    }
    metadata
    network
  }
}
''');

final watchOrdersSubscription = gql('''
  subscription WatchOrders(
  \$where: OrderWhereComplex
  \$sort: OrderSort
  \$limit: Int = 25
  \$skip: Int = 0
) {
  orders(query: true, where: \$where, sort: \$sort, limit: \$limit, skip: \$skip) {
    id
    contract
    orderId
    kind
    open
    openFrom
    openTo
    taker
    maker
    makerExpanded {
      name
      image_avatar
      username
      _id
    }
    bidAmount
    bidder
    token {
      id
      contract
      tokenId
      uri
      creator
      metadata
      network
    }
    price
    currency {
      id
      name
      symbol
    }
    paidAmount
    network
  }
}
''');
