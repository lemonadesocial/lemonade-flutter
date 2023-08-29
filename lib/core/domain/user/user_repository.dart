import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthUser>> getMe();

  Future<Either<Failure, User>> getUserProfile({String? userId, String? username});

  Future<Either<Failure, bool>> updateUserProfile({
    required String username,
    String? uploadPhoto,
    OnboardingGender? gender,
    String? displayName,
    String? shortBio,
  });

  Future<Either<Failure, bool>> checkValidUsername({required String username});
}
