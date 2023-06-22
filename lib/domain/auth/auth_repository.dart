import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> login();
  Future<bool> checkAuthenticated();
}
