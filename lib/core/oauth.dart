import 'package:app/core/config.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

@lazySingleton
class AppOauth {
  final baseOAuthUrl = AppConfig.oauth2BaseUrl;
  final clientId = AppConfig.oauth2ClientId;
  final appUriScheme = AppConfig.oauthRedirectScheme;
  late final redirectUri = '$appUriScheme://oauth2/callback';
  late final logoutRedirectUri = '$appUriScheme://oauth2/logout';
  final scopes = ['openid', 'offline_access'];

  Future<String>? refreshTokenFuture;

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

  Future<Either<Exception, bool>> login() async {
    try {
      var res = await helper.fetchToken();
      return Right(res.accessToken != null);
    } on PlatformException catch (e) {
      return Left(e);
    }
  }

  Future<bool> logout() async {
    try {
      final tknRes = await getTokenFromStorage();
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
      await helper.removeAllTokens();
      return false;
    }
  }

  Future<AccessTokenResponse?> getTokenFromStorage() async {
    return await helper.getTokenFromStorage();
  }

  Future<AccessTokenResponse?> getToken() async {
    return await helper.getToken();
  }

  Future<String> getTokenForGql() async {
    AccessTokenResponse? tokenRes;
    tokenRes = await getTokenFromStorage();
    if (tokenRes == null) return '';
    if (tokenRes.isExpired()) {
      // if token is expired, all coming request have to wait only one refresh token request
      // prevent duplicate call refresh token
      refreshTokenFuture ??= getToken().then((_tokenRes) {
        refreshTokenFuture = null;
        return _tokenRes?.accessToken != null ? 'Bearer ${tokenRes?.accessToken}' : '';
      });
      return refreshTokenFuture!;
    }
    tokenRes = await getToken();

    return tokenRes?.accessToken != null ? 'Bearer ${tokenRes?.accessToken}' : '';
  }
}
