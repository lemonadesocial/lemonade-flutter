import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_exception.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class CustomOAuth2Helper extends OAuth2Helper {
  @override
  final OAuth2Client client;
  @override
  final String clientId;
  @override
  final List<String> scopes;

  CustomOAuth2Helper(
    this.client, {
    required this.clientId,
    required this.scopes,
  }) : super(
          client,
          clientId: clientId,
          scopes: scopes,
          accessTokenHeaders: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          webAuthOpts: {
            'preferEphemeral': true,
          }
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
        throw Exception('Provider error ${tknResp.httpStatusCode}: ${tknResp.error}: ${tknResp.errorDescription}');
      }

      if (!tknResp.isBearer()) {
        throw Exception('Only Bearer tokens are currently supported');
      }
    }

    return tknResp;
  }

  @override
  Future<AccessTokenResponse> refreshToken(AccessTokenResponse curTknResp) async {
    AccessTokenResponse? tknResp;
    var refreshToken = curTknResp.refreshToken!;
    try {
      tknResp = await client.refreshToken(
        refreshToken,
        clientId: clientId,
        clientSecret: clientSecret,
        scopes: curTknResp.scope,
      );
      if (tknResp.isValid()) {
        //If the response doesn't contain a refresh token, keep using the current one
        if (!tknResp.hasRefreshToken()) {
          tknResp.refreshToken = refreshToken;
        }
        await tokenStorage.addToken(tknResp);
      } else {
        if (tknResp.error == 'invalid_grant') {
          //The refresh token is expired too
          await tokenStorage.deleteToken(scopes);
        } else {
          throw OAuth2Exception(tknResp.error ?? 'Error', errorDescription: tknResp.errorDescription);
        }
      }
      return tknResp;
    } catch (_) {
      throw Exception("Refresh token fail");
    }
  }

  void _validateAuthorizationParams() {
    if (clientId.isEmpty) {
      throw Exception('Required "clientId" parameter not set');
    }

    if (grantType == OAuth2Helper.clientCredentials && (clientSecret == null || clientSecret!.isEmpty)) {
      throw Exception('Required "clientSecret" parameter not set');
    }
  }
}
