import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/data/user/dtos/user_follows/user_follow_dtos.dart';
import 'package:app/core/data/user/dtos/user_query.dart';
import 'package:app/core/data/user/gql/user_mutation.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/entities/user_follow.dart';
import 'package:app/core/domain/user/input/user_follows_input.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/user/mutation/update_user.graphql.dart';
import 'package:app/graphql/backend/user/query/get_user.graphql.dart';
import 'package:app/graphql/backend/user/query/get_users.graphql.dart';
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
          final dto = UserDto.fromJson(data['getMe']);
          return User.fromDto(dto);
        },
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, User>> getUserProfile(GetProfileInput input) async {
    try {
      final result = await _gqlClient.query(
        QueryOptions(
          document: getUserQuery,
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) {
            return User.fromDto(UserDto.fromJson(data['getUser']));
          },
          variables: input.toJson(),
        ),
      );

      if (result.hasException) return Left(Failure());
      return Right(result.parsedData!);
    } catch (e) {
      return Left(Failure());
    }
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

  @override
  Future<Either<Failure, bool>> reportUser({
    required String userId,
    required String reason,
    bool isBlock = false,
  }) async {
    final result = await _gqlClient.mutate(
      MutationOptions(
        document: reportUserMutation,
        variables: {'id': userId, 'reason': reason, 'block': isBlock},
        parserFn: (data) {
          return data['reportUser'] as bool?;
        },
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData == true);
  }

  @override
  Future<Either<Failure, List<UserFollow>>> getUserFollows(
    GetUserFollowsInput input,
  ) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserFollowsQuery,
        parserFn: (data) => List.from(data['getUserFollows'] ?? [])
            .map(
              (item) => UserFollow.fromDto(
                UserFollowDto.fromJson(item),
              ),
            )
            .toList(),
        variables: input.toJson(),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, bool>> createUserFollow({
    required String followee,
  }) async {
    final result = await _gqlClient.mutate(
      MutationOptions(
        document: createUserFollowMutation,
        variables: {'followee': followee},
        parserFn: (data) {
          return data['createUserFollow'];
        },
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData != null);
  }

  @override
  Future<Either<Failure, bool>> deleteUserFollow({
    required String followee,
  }) async {
    final result = await _gqlClient.mutate(
      MutationOptions(
        document: deleteUserFollowMutation,
        variables: {'followee': followee},
        parserFn: (data) {
          return data['deleteUserFollow'];
        },
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData != null);
  }

  @override
  Future<Either<Failure, bool>> toggleBlockUser({
    required String userId,
    required bool isBlock,
  }) async {
    final result = await _gqlClient.mutate(
      MutationOptions(
        document: toggleBlockUserQuery,
        variables: {'id': userId, 'block': isBlock},
        parserFn: (data) {
          return data['toggleBlockUser'] as bool?;
        },
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData == true);
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    final result = await _gqlClient.mutate(
      MutationOptions(
        document: deleteUserMutation,
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) {
          return data['deleteUser'] ?? false;
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? false);
  }

  @override
  Future<Either<Failure, Mutation$UpdateUser>> updateUserAddresses({
    required Input$UserInput input,
  }) async {
    final result = await _gqlClient.mutate$UpdateUser(
      Options$Mutation$UpdateUser(
        variables: Variables$Mutation$UpdateUser(input: input),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, List<User>>> getUsers({
    int? skip,
    int? limit,
    String? search,
  }) async {
    final result = await _gqlClient.query$GetUsers(
      Options$Query$GetUsers(
        variables: Variables$Query$GetUsers(
          limit: limit!,
          skip: skip!,
          search: search!,
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      List.from(
        result.parsedData!.getUsers
            .map((item) => User.fromDto(UserDto.fromJson(item.toJson())))
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, User>> getUser({
    required String userId,
  }) async {
    final result = await _gqlClient.query$GetUser(
      Options$Query$GetUser(
        variables: Variables$Query$GetUser(
          id: userId,
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      User.fromDto(UserDto.fromJson(result.parsedData!.getUser!.toJson())),
    );
  }

  @override
  Future<Either<Failure, bool>> updateUser({
    required Input$UserInput input,
  }) async {
    final result = await _gqlClient.mutate$UpdateUser(
      Options$Mutation$UpdateUser(
        variables: Variables$Mutation$UpdateUser(
          input: input,
        ),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData != null);
  }
}
