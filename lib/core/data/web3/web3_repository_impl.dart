import 'package:app/core/data/web3/dtos/chain_dto.dart';
import 'package:app/core/data/web3/web3_query.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

@LazySingleton(as: Web3Repository)
class Web3RepositoryIml implements Web3Repository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<Chain>>> getChainsList() async {
    final result = await _client.query(
      QueryOptions(
        document: getChainsListQuery,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        parserFn: (data) => List.from(data['listChains'] ?? [])
            .map(
              (item) => Chain.fromDto(
                ChainDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, Chain?>> getChainById({
    required String chainId,
  }) async {
    final getChainsResult = await getChainsList();
    if (getChainsResult.isLeft()) {
      return Left(Failure());
    }
    final chains = getChainsResult.getOrElse(() => []);
    return Right(
      chains.firstWhereOrNull((element) => element.chainId == chainId),
    );
  }
}
