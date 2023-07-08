import 'package:app/core/domain/token/entities/order_entities.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TokenService {
  final TokenRepository tokenRepository;
  TokenService(this.tokenRepository);

  Future<Either<Failure, List<TokenComplex>>> getTokens({GetTokensInput? input}) {
    return tokenRepository.getTokens(input: input);
  }

  Stream<Either<Failure, QueryResult<List<OrderComplex>>>> watchOrders({WatchOrdersInput? input}) {
    return tokenRepository.watchOrders(input: input);
  }
}
