import 'package:app/core/data/vault/dtos/free_safe_init_info_dto/free_safe_init_info_dto.dart';
import 'package:app/core/data/vault/query/vault_query.dart';
import 'package:app/core/domain/vault/entities/free_safe_init_info/free_safe_init_info.dart';
import 'package:app/core/domain/vault/input/get_init_safe_transaction_input/get_init_safe_transaction_input.dart';
import 'package:app/core/domain/vault/input/get_safe_free_limit_input/get_safe_free_limit_input.dart';
import 'package:app/core/domain/vault/vault_repository.dart';
import 'package:app/core/domain/web3/entities/raw_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VaultRepository)
class VaultRepositoryImpl implements VaultRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, RawTransaction>> getInitSafeTransaction({
    required GetInitSafeTransactionInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        variables: {
          'input': input.toJson(),
        },
        document: getInitSafeTransactionQuery,
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) =>
            RawTransaction.fromJson(data['getInitSafeTransaction']),
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, FreeSafeInitInfo>> getSafeFreeLimit({
    required GetSafeFreeLimitInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getSafeFreeLimitQuery,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: input.toJson(),
        parserFn: (data) => data['getSafeFreeLimit'] != null
            ? FreeSafeInitInfo.fromDto(
                FreeSafeInitInfoDto.fromJson(data['getSafeFreeLimit']),
              )
            : null,
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }

    return Right(result.parsedData!);
  }
}
