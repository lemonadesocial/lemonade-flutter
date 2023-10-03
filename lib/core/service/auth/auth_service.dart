import 'dart:async';

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
    final res = await appOAuth.login();
    return res.fold(
      (l) => Left(Failure()),
      (success) {
        if (success) {
          return const Right(true);
        }
        return Left(Failure());
      },
    );
  }

  Future<Either<Failure, bool>> logout() async {
    firebaseService.removeFcmToken();
    final res = await appOAuth.logout();
    return res.fold(
      (l) => Left(Failure()),
      (success) {
        if (success) return const Right(true);

        return Left(Failure());
      },
    );
  }

  Future<Either<Failure, bool>> deleteAccount() async {
    firebaseService.removeFcmToken();
    return appOAuth.deleteAccount();
  }
}
