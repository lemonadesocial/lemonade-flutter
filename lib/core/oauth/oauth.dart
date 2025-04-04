import 'dart:async';

import 'package:app/core/config.dart';
import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:app/core/oauth/custom_oauth_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:rxdart/rxdart.dart';

class OauthError {
  static String userCancelled = 'org.openid.appauth.general error -3';
}

enum OAuthTokenState {
  unknown,
  valid,
  invalid,
}

@lazySingleton
class AppOauth {
  final baseOAuthUrl = AppConfig.oauth2BaseUrl;
  final clientId = AppConfig.oauth2ClientId;
  final appUriScheme = AppConfig.oauthRedirectScheme;
  late final redirectUri = '$appUriScheme://oauth2/callback';
  late final logoutRedirectUri = '$appUriScheme://oauth2/logout';
  final scopes = ['openid', 'offline_access'];

  final BehaviorSubject<OAuthTokenState> _tokenStateStreamCtrl =
      BehaviorSubject();
  OAuthTokenState _tokenState = OAuthTokenState.unknown;

  Future<String>? refreshTokenFuture;

  Stream<OAuthTokenState> get tokenStateStream => _tokenStateStreamCtrl.stream;

  OAuthTokenState get tokenState => _tokenState;

  late final OAuth2Client client = OAuth2Client(
    authorizeUrl: '$baseOAuthUrl/auth',
    tokenUrl: '$baseOAuthUrl/token',
    revokeUrl: '$baseOAuthUrl/sessions/logout',
    redirectUri: redirectUri,
    customUriScheme: appUriScheme,
  );

  late final CustomOAuth2Helper helper = CustomOAuth2Helper(
    client,
    clientId: clientId,
    scopes: scopes,
  );

  init() async {
    await _checkTokenState();
  }

  Future<Either<Exception, bool>> login() async {
    try {
      var res = await _processTokenState(helper.fetchToken());
      if (res?.isValid() == true) {
        return const Right(true);
      }
      return Left(Exception(res?.error));
    } on PlatformException catch (e) {
      _reset();
      return Left(e);
    }
  }

  Future<Either<Exception, bool>> logout() async {
    try {
      final tknRes = await helper.getTokenFromStorage();
      await const FlutterAppAuth().endSession(
        EndSessionRequest(
          preferEphemeralSession: true,
          idTokenHint: tknRes?.getRespField('id_token'),
          postLogoutRedirectUrl: logoutRedirectUri,
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: client.authorizeUrl,
            tokenEndpoint: client.tokenUrl,
            endSessionEndpoint: client.revokeUrl,
          ),
        ),
      );
      await _reset();
      return const Right(true);
    } on PlatformException catch (e) {
      if (e.message?.contains(OauthError.userCancelled) == true) {
        return Left(e);
      }
      await _reset();
      return const Right(true);
    } catch (error) {
      await _reset();
      return const Right(true);
    }
  }

  Future<void> forceLogout() async {
    _reset();
  }

  Future<AccessTokenResponse?> manuallyRefreshToken(
    AccessTokenResponse tokenResponse,
  ) async =>
      helper.refreshToken(tokenResponse);

  Future<AccessTokenResponse?> getTokenFromStorage() =>
      helper.getTokenFromStorage();

  Future<AccessTokenResponse?> getToken() async => helper.getToken();

  Future<String> getTokenForGql() async {
    if (refreshTokenFuture != null) {
      return refreshTokenFuture!;
    }

    try {
      refreshTokenFuture = _getTokenAndProcess();
      final result = await refreshTokenFuture!;
      return result;
    } finally {
      refreshTokenFuture = null;
    }
  }

  Future<String> _getTokenAndProcess() async {
    try {
      final tokenRes = await helper.getToken();
      if (tokenRes == null || !tokenRes.isValid()) {
        CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
          category: 'oauth',
          message: '_getTokenAndProcess token is invalid',
          params: {
            'isNull': tokenRes == null,
            'error': tokenRes?.error,
            'errorDescription': tokenRes?.errorDescription,
          },
        );
        await _processTokenState(Future.value(null));
        return '';
      }

      await _processTokenState(Future.value(tokenRes));
      return tokenRes.accessToken ?? '';
    } catch (e) {
      CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
        category: 'oauth',
        message: 'Token processing error',
        params: {
          'error': e.toString(),
        },
      );
      await _processTokenState(Future.value(null));
      rethrow;
    }
  }

  Future<void> _checkTokenState() async {
    await _processTokenState(helper.getToken());
  }

  Future<AccessTokenResponse?> _processTokenState(
    Future<AccessTokenResponse?> future,
  ) async {
    try {
      final token = await future;
      if (token == null || !token.isValid() || token.isExpired()) {
        _reset();
      } else {
        _updateTokenState(OAuthTokenState.valid);
      }
      return token;
    } catch (e) {
      _reset();
      return null;
    }
  }

  Future<void> _reset() async {
    CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
      category: 'oauth',
      message: 'Token reset triggered',
      params: {
        'previousState': _tokenState.toString(),
      },
    );
    await helper.removeAllTokens();
    _updateTokenState(OAuthTokenState.invalid);
  }

  void _updateTokenState(OAuthTokenState newState) {
    if (_tokenState != newState) {
      _tokenState = newState;
      _tokenStateStreamCtrl.add(newState);
    }
  }
}
