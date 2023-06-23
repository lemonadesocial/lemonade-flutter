import 'package:app/core/failure.dart';
import 'package:app/core/oauth.dart';
import 'package:app/domain/auth/auth_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final appOAuth = getIt<AppOauth>();

  @override
  Future<bool> checkAuthenticated() async {
    var res = await appOAuth.getTokenFromStorage();
    return res?.accessToken != null;
  }

  @override
  Future<Either<Failure, bool>> login() async {
    var res = await appOAuth.login();
    return res.fold(
      (l) => Left(Failure()),
      (success) {
        if (success) return const Right(true);

        return Left(Failure());
      },
    );
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    var logOutSuccess = await appOAuth.logout();
    if (logOutSuccess) {
      return const Right(true);
    }
    return Left(Failure());
  }
}
