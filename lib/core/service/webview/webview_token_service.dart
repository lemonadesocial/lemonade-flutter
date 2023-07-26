import 'dart:async';

import 'package:app/core/oauth/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:oauth2_client/access_token_response.dart';

class WebviewTokenService {
  final _appOauth = getIt<AppOauth>();
  Timer? _timer;

  final Function(String accessToken) onTokenChanged;

  WebviewTokenService({
    required this.onTokenChanged,
  });

  Future<void> start() async {
    await _getToken();
  }

  void cancel() {
    _stopTokenRefresher();
  }

  Future<Map<String, String>?> generateHeaderWithToken() async {
    final tokenRes = await _getCurrentOrNewToken();
    if (tokenRes != null && tokenRes.isValid()) {
      return {'x-token': '${tokenRes.accessToken}'};
    }
    return null;
  }

  Future<void> _getToken() async {
    if (_timer != null) {
      throw new Exception('Waiting for next refresh');
    }

    try {
      AccessTokenResponse? tokenRes = await _getCurrentOrNewToken();

      if (tokenRes == null || !tokenRes.isValid() || tokenRes.isExpired()) {
        _stopTokenRefresher();
        throw new Exception('Refresh token failed');
      }

      String accessToken = tokenRes.accessToken ?? '';

      _onTokenChanged(accessToken);

      // here we can be sure that token expiration date is greater than now;
      int timeUntilRefresh = _getTimeUntilExpired(tokenRes) - 30;

      if (timeUntilRefresh <= 0) {
        _stopTokenRefresher();
        throw new Exception('Invalid token expiredIn');
      }

      _timer = Timer(Duration(seconds: timeUntilRefresh), () async {
        await _getToken();
      });
    } catch (e) {
      debugPrint('WebViewTokenService: $e');
    }
  }

  void _stopTokenRefresher() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  // refresh brand new token
  Future<AccessTokenResponse?> _getCurrentOrNewToken() async {
    AccessTokenResponse? curToken;

    curToken = await _appOauth.getTokenFromStorage();
    if (curToken == null) return null;

    final timeUntilExpired = _getTimeUntilExpired(curToken);

    //if token already expired, refresh token
    if (timeUntilExpired == -1) {
      return await _appOauth.manuallyRefreshToken(curToken);
    }

    // if token is about to expired within 30s, refresh token
    if (timeUntilExpired <= 30) {
      return await _appOauth.manuallyRefreshToken(curToken);
    }

    return curToken;
  }

  int _getTimeUntilExpired(AccessTokenResponse tokenResponse) {
    if (tokenResponse.isExpired()) return -1;

    final now = DateTime.now();
    final expirationDate = tokenResponse.expirationDate!;

    if (now.isBefore(expirationDate)) {
      final durationInSecs = expirationDate.difference(now).inSeconds;
      return durationInSecs;
    }

    return -1;
  }

  void _onTokenChanged(String token) {
    onTokenChanged(token);
  }
}
