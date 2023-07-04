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
      document: getMeQuery,
      parserFn: (data) {
        return AuthUser.fromDto(UserDto.fromJson(data['getMe']));
      },
    ));

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, User>> getUserProfile({ String? userId, String? username }) async {
    assert(userId != null || username != null);
    final result = await _gqlClient.query(QueryOptions(
      document: getUserQuery,
      parserFn: (data) {
        return User.fromDto(UserDto.fromJson(data['getUser']));
      },
      variables: {
        'id': userId,
        'username': username
      }
    ));

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }
}
