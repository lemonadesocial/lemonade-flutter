import 'dart:async';

import 'package:app/core/config.dart';
import 'package:app/core/domain/lens/entities/lens_auth.dart';
import 'package:app/graphql/lens/auth/mutation/lens_refresh_token.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

enum LensTokenState {
  valid,
  invalid,
}

@LazySingleton()
class LensStorageService {
  final _storage = const FlutterSecureStorage();
  final BehaviorSubject<LensTokenState> _tokenStateStreamCtrl =
      BehaviorSubject();

  Completer<String?>? _refreshTokenCompleter;

  DateTime? lastRefresh;

  Stream<LensTokenState> get tokenStateStream => _tokenStateStreamCtrl.stream;

  static const _keyAccessToken = 'lens_access_token';
  static const _keyRefreshToken = 'lens_refresh_token';
  static const _keyIdToken = 'lens_id_token';

  Future<bool> hasLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? idToken, // idToken might be optional or not used
  }) async {
    lastRefresh = DateTime.now();
    await _storage.write(key: _keyAccessToken, value: accessToken);
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
    if (idToken != null) {
      await _storage.write(key: _keyIdToken, value: idToken);
    } else {
      // If idToken is null, ensure it's removed from storage if previously set
      await _storage.delete(key: _keyIdToken);
    }
    _tokenStateStreamCtrl.add(LensTokenState.valid);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  Future<String?> getIdToken() async {
    return await _storage.read(key: _keyIdToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyIdToken);
    _tokenStateStreamCtrl.add(LensTokenState.invalid);
  }

  Future<String?> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      _tokenStateStreamCtrl.add(LensTokenState.invalid);
      return null;
    }
    final result = await _callRefreshMutation(refreshToken: refreshToken);
    if (result is LensRefreshTokens) {
      await saveTokens(
        accessToken: result.accessToken!,
        refreshToken: result.refreshToken!,
        idToken: result.idToken,
      );
      return result.accessToken!;
    } else {
      await clearTokens();
      return null;
    }
  }

  Future<String?> getAccessTokenForQql() async {
    // If a refresh operation is already in progress, wait for its result
    if (_refreshTokenCompleter != null &&
        !_refreshTokenCompleter!.isCompleted) {
      return _refreshTokenCompleter!.future;
    }
    // Check if the token needs refreshing (e.g., based on time)
    // Using the 5-minute logic from the original code.
    // TODO: Consider using actual token expiry time if available from the idToken.
    final needsRefresh = lastRefresh == null ||
        DateTime.now().difference(lastRefresh!).inMinutes >= 5;

    if (!needsRefresh) {
      final currentToken = await getAccessToken();
      if (currentToken != null) {
        return currentToken;
      } else {
        return null;
      }
    }

    _refreshTokenCompleter = Completer<String?>();
    try {
      final newAccessToken = await refreshToken();
      _refreshTokenCompleter!.complete(newAccessToken);
    } catch (e) {
      _refreshTokenCompleter!.complete(null);
    }
    return _refreshTokenCompleter!.future;
  }
}

Future<LensRefreshResult> _callRefreshMutation({
  required String refreshToken,
}) async {
  // IMPORTANT: Use a separate, simple client for the refresh mutation
  // to avoid infinite loops if the refresh token itself is invalid during the error handling.
  final simpleHttpLink = HttpLink(
    AppConfig.lensApiUrl,
    defaultHeaders: {
      'Content-Type': 'application/json',
      'Origin': AppConfig.webUrl,
    },
  );
  final simpleClient = GraphQLClient(
    queryRequestTimeout: const Duration(seconds: 30),
    cache: GraphQLCache(),
    link: simpleHttpLink,
  );

  final result = await simpleClient.mutate$LensRefreshToken(
    Options$Mutation$LensRefreshToken(
      variables: Variables$Mutation$LensRefreshToken(
        request: Input$RefreshRequest(
          refreshToken: refreshToken,
        ),
      ),
    ),
  );
  if (result.hasException || result.parsedData?.refresh == null) {
    throw result.exception!;
  }
  final data = result.parsedData!.refresh.when(
    authenticationTokens: (tokens) {
      return LensRefreshResult.tokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        idToken: tokens.idToken,
      );
    },
    forbiddenError: (forbiddenError) {
      return LensRefreshResult.forbiddenError(
        reason: forbiddenError.reason,
      );
    },
    orElse: () {
      return const LensRefreshResult.forbiddenError(reason: "Unknown error");
    },
  );

  return data;
}
