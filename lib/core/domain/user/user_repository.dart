import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthUser>> getMe();
  Future<Either<Failure, User>> getUserProfile({ String? userId, String? username });
}
