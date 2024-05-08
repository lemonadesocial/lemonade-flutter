import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/entities/user_expertise.dart';
import 'package:app/core/domain/user/entities/user_follow.dart';
import 'package:app/core/domain/user/entities/user_icebreaker.dart';
import 'package:app/core/domain/user/entities/user_service_offer.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/user/mutation/update_user.graphql.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/domain/user/input/user_follows_input.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getMe();

  Future<Either<Failure, User>> getUserProfile(GetProfileInput input);

  Future<Either<Failure, bool>> updateUserProfile(UpdateUserProfileInput input);

  Future<Either<Failure, bool>> checkValidUsername({required String username});

  Future<Either<Failure, bool>> reportUser({
    required String userId,
    required String reason,
    bool isBlock = false,
  });

  Future<Either<Failure, bool>> toggleBlockUser({
    required String userId,
    required bool isBlock,
  });

  Future<Either<Failure, List<UserFollow>>> getUserFollows(
    GetUserFollowsInput input,
  );

  Future<Either<Failure, bool>> createUserFollow({required String followee});

  Future<Either<Failure, bool>> deleteUserFollow({required String followee});

  Future<Either<Failure, bool>> deleteUser();

  Future<Either<Failure, Mutation$UpdateUser>> updateUserAddresses({
    required Input$UserInput input,
  });

  Future<Either<Failure, List<User>>> getUsers({
    int? skip,
    int? limit,
    String? search,
  });

  Future<Either<Failure, User>> getUser({
    required String userId,
  });

  Future<Either<Failure, bool>> updateUser({required Input$UserInput input});

  Future<Either<Failure, List<UserIcebreakerQuestion>>>
      getUserIcebreakerQuestions();

  Future<Either<Failure, List<UserExpertise>>> getListUserExpertises();

  Future<Either<Failure, List<UserServiceOffer>>> getListUserServices();
}
