import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService {
  final _userRepository = getIt<UserRepository>();
  Future<Either<Failure, User>> getMe() async {
    return _userRepository.getMe();
  }
}
