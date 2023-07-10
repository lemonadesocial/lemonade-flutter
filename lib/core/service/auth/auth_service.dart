import 'dart:async';

import 'package:app/core/domain/auth/entities/auth_session.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';


typedef OnTokenChangeHandler = void Function(OAuthTokenState tokenState);

class AuthService {
  final appOAuth = getIt<AppOauth>();
  final OnTokenChangeHandler? onTokenStateChanged;
  late final StreamSubscription<OAuthTokenState> tokenStateSubscription;

  AuthService({this.onTokenStateChanged}) {
    tokenStateSubscription = appOAuth.tokenStateStream.listen((tokenState) {
      onTokenStateChanged?.call(tokenState);
    });
  }

  Future<void> close() async {
    await tokenStateSubscription.cancel();
    await appOAuth.dispose();
  }

  Future<bool> checkAuthenticated() async {
    var res = await appOAuth.getTokenFromStorage();
    return res?.accessToken != null;
  }

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

  Future<bool> logout() async {
    return await appOAuth.logout();
  }

  AuthSession createSession(AuthUser user) {
    return AuthSession(
      userId: user.id,
      userAvatar: user.imageAvatar,
    );
  }
}
