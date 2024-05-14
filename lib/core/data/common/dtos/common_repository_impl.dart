import 'package:app/core/domain/common/common_repository.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/common/query/list_all_currencies.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CommonRepository)
class CommonRepositoryImpl implements CommonRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<Currency>>> listAllCurrencies() async {
    final result = await _client.query$ListAllCurrencies(
      Options$Query$ListAllCurrencies(
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );
    if (result.hasException || result.parsedData?.listAllCurrencies == null) {
      return Left(Failure());
    }
    return Right(
      (result.parsedData?.listAllCurrencies ?? [])
          .map(
            (item) => Currency.fromJson(
              item.toJson(),
            ),
          )
          .toList(),
    );
  }
}
