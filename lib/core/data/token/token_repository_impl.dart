import 'package:app/core/data/token/dtos/order_dtos.dart';
import 'package:app/core/data/token/dtos/token_dtos.dart';
import 'package:app/core/data/token/token_query.dart';
import 'package:app/core/domain/token/entities/order_entities.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenRepository)
class TokenRepositoryImpl implements TokenRepository {
  final _metaverseClient = getIt<MetaverseGQL>().client;

  @override
  Future<Either<Failure, List<TokenComplex>>> getTokens({
    required GetTokensInput input,
  }) async {
    final result = await _metaverseClient.query(
      QueryOptions(
        operationName: 'getTokens',
        document: getTokensQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) {
          return List.from(data['tokens'] ?? [])
              .map(
                (item) => TokenComplex.fromDto(TokenComplexDto.fromJson(item)),
              )
              .toList();
        },
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, TokenDetail?>> getToken({
    required GetTokenDetailInput input,
  }) async {
    final result = await _metaverseClient.query(
      QueryOptions(
        document: getTokenQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) {
          if (data['getToken'] == null) {
            return null;
          }
          return TokenDetail.fromDto(
            TokenDetailDto.fromJson(
              data['getToken'],
            ),
          );
        },
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData);
  }

  @override
  Stream<Either<Failure, List<OrderComplex>>> watchOrders({
    required WatchOrdersInput input,
  }) {
    final stream = _metaverseClient.subscribe(
      SubscriptionOptions(
        document: watchOrdersSubscription,
        variables: input.toJson(),
        parserFn: (data) => List.from(data['orders'] ?? [])
            .map((item) => OrderComplex.fromDto(OrderComplexDto.fromJson(item)))
            .toList(),
      ),
    );

    return stream.asyncMap((result) {
      if (result.hasException) return Left(Failure());
      return Right(result.parsedData ?? []);
    });
  }
}
