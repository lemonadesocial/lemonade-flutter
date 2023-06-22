import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

@lazySingleton
class AppOauth {
  final baseOAuthUrl = 'https://oauth2.staging.lemonade.social/oauth2';
  final clientId = "4a0846d5-2b06-4d61-821f-907fc2545b31";
  final scopes = ['openid', 'offline_access'];
  final appUriScheme = 'lemonadesocial';
  late final redirectUri = '$appUriScheme://oauth2/callback';
  late final logoutRedirectUri = '$appUriScheme://oauth2/logout';

  late final OAuth2Client client = OAuth2Client(
    authorizeUrl: '$baseOAuthUrl/auth',
    tokenUrl: '$baseOAuthUrl/token',
    revokeUrl: '$baseOAuthUrl/sessions/logout',
    redirectUri: redirectUri,
    customUriScheme: appUriScheme,
  );

  late final OAuth2Helper helper = OAuth2Helper(client,
      clientId: clientId,
      accessTokenHeaders: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      scopes: scopes);

  Future<bool> logout() async {
    try {
      final tknRes = await getToken();
      await const FlutterAppAuth().endSession(EndSessionRequest(
          idTokenHint: tknRes?.getRespField('id_token'),
          postLogoutRedirectUrl: logoutRedirectUri,
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: client.authorizeUrl,
            tokenEndpoint: client.tokenUrl,
            endSessionEndpoint: client.revokeUrl,
          )));
      await helper.removeAllTokens();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AccessTokenResponse?> getTokenFromStorage() async {
    return await helper.getTokenFromStorage();
  }

  Future<AccessTokenResponse?> getToken() async {
    return await helper.getToken();
  }

  Future<Either<Exception, bool>> login() async {
    try {
      var res = await helper.fetchToken();
      return Right(res.accessToken != null);
    } on PlatformException catch (e) {
      return Left(e);
    }
  }
}
