import 'dart:async';

import 'package:app/core/domain/auth/entities/auth_session.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthService {
  final appOAuth = getIt<AppOauth>();
  final firebaseService = getIt<FirebaseService>();
  Stream<OAuthTokenState> get tokenStateStream => appOAuth.tokenStateStream;

  Future<Either<Failure, bool>> login() async {
    var res = await appOAuth.login();
    return res.fold(
      (l) => Left(Failure()),
      (success) {
        if (success) {
          firebaseService.removeFcmToken();
          return const Right(true);
        }
        return Left(Failure());
      },
    );
  }

  Future<Either<Failure, bool>> logout() async {
    firebaseService.removeFcmToken();
    var res = await appOAuth.logout();
    return res.fold(
      (l) => Left(Failure()),
      (success) {
        if (success) return const Right(true);

        return Left(Failure());
      },
    );
  }

  AuthSession createSession(AuthUser user) {
    return AuthSession(
      userId: user.id,
      userAvatar: user.imageAvatar,
      userDisplayName: user.displayName,
      username: user.username,
    );
  }
}
