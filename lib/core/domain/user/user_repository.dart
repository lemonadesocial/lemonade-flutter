import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/entities/user_follow.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/domain/user/input/user_follows_input.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getMe();

  Future<Either<Failure, User>> getUserProfile(GetProfileInput input);

  Future<Either<Failure, bool>> updateUserProfile(UpdateUserProfileInput input);

  Future<Either<Failure, bool>> checkValidUsername({required String username});

  Future<Either<Failure, List<UserFollow>>> getUserFollows(
      GetUserFollowsInput input);
}
