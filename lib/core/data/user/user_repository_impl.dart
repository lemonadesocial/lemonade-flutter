import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/data/user/dtos/user_query.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final _gqlClient = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, AuthUser>> getMe() async {
    final result = await _gqlClient.query(QueryOptions(
      document: getUserQuery,
      parserFn: (data) {
        return AuthUser.fromDto(UserDto.fromJson(data['getUser']));
      },
    ));

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }
}
