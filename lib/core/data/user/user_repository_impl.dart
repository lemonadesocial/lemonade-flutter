import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/data/user/dtos/user_query.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import 'package:app/core/data/onboarding/onboarding_query.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final _gqlClient = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, User>> getMe() async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getMeQuery,
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) {
          return User.fromDto(UserDto.fromJson(data['getMe']));
        },
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, User>> getUserProfile(GetProfileInput input) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserQuery,
        parserFn: (data) {
          return User.fromDto(UserDto.fromJson(data['getUser']));
        },
        variables: input.toJson(),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(
    UpdateUserProfileInput input,
  ) async {
    final result = await _gqlClient.mutate(
      MutationOptions(
        document: updateUserProfileQuery,
        variables: input.toJson(),
        parserFn: (data) {
          return data['updateUser'];
        },
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData != null);
  }

  @override
  Future<Either<Failure, bool>> checkValidUsername({
    required String username,
  }) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: checkValidUsernameQuery,
        parserFn: (data) {
          final getUser = data['getUser'];
          return getUser == null ? false : getUser['active'];
        },
        variables: {'username': username},
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData);
  }
}
