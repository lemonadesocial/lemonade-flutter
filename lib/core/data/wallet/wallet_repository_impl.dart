import 'package:app/core/data/wallet/dtos/wallet_dtos.dart';
import 'package:app/core/data/wallet/wallet_mutation.dart';
import 'package:app/core/data/wallet/wallet_query.dart';
import 'package:app/core/domain/wallet/entities/wallet_entities.dart';
import 'package:app/core/domain/wallet/wallet_repository.dart';

import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final _gqlClient = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, UserWalletRequest?>> getUserWalletRequest({
    required String wallet,
  }) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserWalletRequestQuery,
        variables: {
          'wallet': wallet,
        },
        parserFn: (data) => UserWalletRequest.fromDto(
          UserWalletRequestDto.fromJson(data['getUserWalletRequest']),
        ),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData);
  }

  @override
  Future<Either<Failure, bool>> setUserWallet({
    required String token,
    required String signature,
  }) async {
    final result = await _gqlClient.mutate(
      MutationOptions(
        document: setUserWalletMutation,
        variables: {
          'signature': signature,
          'token': token,
        },
        parserFn: (data) => data['setUserWallet'],
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData == true);
  }
}
