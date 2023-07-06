import 'package:app/core/domain/token/entities/order_entities.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class TokenRepository {
  Future<Either<Failure, List<TokenComplex>>> getTokens({GetTokensInput? input});

  Stream<Either<Failure, QueryResult<List<OrderComplex>>>> watchOrders({WatchOrdersInput? input});
}
