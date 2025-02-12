import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_exception.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class CustomOAuth2Helper extends OAuth2Helper {
  CustomOAuth2Helper(
    super.client, {
    required super.clientId,
    required List<String> super.scopes,
  }) : super(
          accessTokenHeaders: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          webAuthOpts: {
            'preferEphemeral': true,
          },
        );

  @override
  Future<AccessTokenResponse?> getToken() async {
    _validateAuthorizationParams();
    var tknResp = await getTokenFromStorage();

    if (tknResp != null) {
      if (tknResp.refreshNeeded()) {
        //The access token is expired
        if (tknResp.hasRefreshToken()) {
          tknResp = await refreshToken(tknResp);
        }
      }

      if (!tknResp.isValid()) {
        CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
          category: 'oauth',
          message: 'getToken token is invalid',
          params: {
            'status_code': tknResp.httpStatusCode,
            'error': tknResp.error,
            'error_description': tknResp.errorDescription,
          },
        );
        throw Exception(
          'Provider error ${tknResp.httpStatusCode}: ${tknResp.error}: ${tknResp.errorDescription}',
        );
      }

      if (!tknResp.isBearer()) {
        CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
          category: 'oauth',
          message: 'Unsupported token type',
          params: {
            'token_type': tknResp.tokenType,
          },
        );
        throw Exception('Only Bearer tokens are currently supported');
      }
    }

    return tknResp;
  }

  @override
  Future<AccessTokenResponse> refreshToken(
    AccessTokenResponse curTknResp,
  ) async {
    AccessTokenResponse? tknResp;
    var refreshToken = curTknResp.refreshToken!;
    try {
      tknResp = await client.refreshToken(
        refreshToken,
        clientId: clientId,
        scopes: curTknResp.scope,
      );
      CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
        category: 'oauth',
        message: 'Refresh token successful',
        params: {
          'access_token': tknResp.accessToken,
          'refresh_token': tknResp.refreshToken,
          'expires_in': tknResp.expiresIn,
          'scope': tknResp.scope,
          'token_type': tknResp.tokenType,
        },
      );
    } catch (e) {
      CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
        category: 'oauth',
        message: 'Refresh token failed, attempting new token fetch',
        params: {
          'error': e.toString(),
        },
      );
      return await fetchToken();
    }

    if (tknResp.isValid()) {
      //If the response doesn't contain a refresh token, keep using the current one
      if (!tknResp.hasRefreshToken()) {
        tknResp.refreshToken = refreshToken;
      }

      await tokenStorage.addToken(tknResp);
    } else {
      if (tknResp.error == 'invalid_grant') {
        CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
          category: 'oauth',
          message: 'Received invalid_grant error',
          params: {
            'scopes': scopes,
          },
        );
        await tokenStorage.deleteToken(scopes ?? []);
        //Fetch another access token
        tknResp = await getToken();
      } else {
        CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
          category: 'oauth',
          message: 'Refresh token failed',
          params: {
            'error': tknResp.error,
            'error_description': tknResp.errorDescription,
          },
        );
        throw OAuth2Exception(
          tknResp.error ?? 'Error',
          errorDescription: tknResp.errorDescription,
        );
      }
    }

    return tknResp!;
  }

  void _validateAuthorizationParams() {
    if (clientId.isEmpty) {
      CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
        category: 'oauth',
        message: 'Required "clientId" parameter not set',
        params: {},
      );
      throw Exception('Required "clientId" parameter not set');
    }

    if (grantType == OAuth2Helper.clientCredentials &&
        (clientSecret == null || clientSecret!.isEmpty)) {
      CrashAnalyticsManager().crashAnalyticsService?.addBreadcrumb(
        category: 'oauth',
        message: 'Required "clientSecret" parameter not set',
        params: {},
      );
      throw Exception('Required "clientSecret" parameter not set');
    }
  }
}
