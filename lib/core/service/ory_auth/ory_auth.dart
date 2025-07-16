import 'package:app/core/config.dart';
import 'package:app/core/service/storage/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ory_client/ory_client.dart';
import 'package:one_of/one_of.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

enum OrySessionState {
  unknown,
  valid,
  invalid,
}

@lazySingleton
class OryAuth {
  final String baseUrl = AppConfig.oryBaseUrl;
  late final OryClient _oryClient;
  late final FrontendApi _api;
  final sessionStorageKey = 'ory_session';
  final BehaviorSubject<OrySessionState> _sessionStateStreamCtrl =
      BehaviorSubject();

  Stream<OrySessionState> get orySessionStateStream =>
      _sessionStateStreamCtrl.stream;

  Future<String>? getGqlTokenFuture;

  OrySessionState get orySessionState =>
      _sessionState ?? OrySessionState.unknown;

  OrySessionState? _sessionState;

  init() async {
    await _checkSessionState();
  }

  OryAuth() {
    _oryClient = OryClient(
      basePathOverride: baseUrl,
    );
    _api = _oryClient.getFrontendApi();
  }

  Future<SuccessfulNativeRegistration> signupWithWallet({
    required String walletAddress,
    required String signature,
    required String token,
  }) async {
    final flowData = await _api.createNativeRegistrationFlow();
    if (flowData.data == null) {
      await _reset();
      throw Exception('Failed to create login flow');
    }

    final updateSignupBody = _createWalletSignupBody(
      signature: signature,
      token: token,
      walletAddress: walletAddress,
    );
    final successNativeRegistration = await _api.updateRegistrationFlow(
      flow: flowData.data!.id,
      updateRegistrationFlowBody: updateSignupBody,
    );
    await _saveSessionToken(successNativeRegistration.data!.sessionToken ?? "");
    await _processSessionState(_getSession());
    if (successNativeRegistration.data == null) {
      await _reset();
      throw Exception(
        'Failed to register ${successNativeRegistration.statusMessage}',
      );
    }
    return successNativeRegistration.data!;
  }

  Future<(bool, Either<LoginFlow?, SuccessfulNativeLogin?>)> loginWithWallet({
    required String walletAddress,
    required String signature,
    required String token,
  }) async {
    Either<LoginFlow?, SuccessfulNativeLogin?> loginResult;
    bool success = false;
    try {
      final flowData = await _api.createNativeLoginFlow();
      if (flowData.data == null) {
        throw Exception('Failed to create login flow');
      }

      final updateLoginFlowBody = _createWalletLoginBody(
        signature: signature,
        token: token,
        walletAddress: walletAddress,
      );

      final successNativeLogin = await _api.updateLoginFlow(
        flow: flowData.data!.id,
        updateLoginFlowBody: updateLoginFlowBody,
      );
      if (successNativeLogin.data == null) {
        throw Exception(
          'Failed to update login flow ${successNativeLogin.statusMessage}',
        );
      }
      loginResult = Right(successNativeLogin.data!);
      success = true;
      await _saveSessionToken(successNativeLogin.data!.sessionToken ?? "");
      await _processSessionState(_getSession());
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final loginFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(LoginFlow),
        ) as LoginFlow?;
        loginResult = Left(loginFlow);
      } else {
        loginResult = const Left(null);
        await _reset();
      }
      success = false;
    }
    return (success, loginResult);
  }

  Future<void> logout() async {
    final sessionToken = await _getSessionToken();
    final response = await _api.performNativeLogout(
      performNativeLogoutBody: PerformNativeLogoutBody(
        (b) => b..sessionToken = sessionToken ?? "",
      ),
    );
    if (response.statusCode == 204) {
      _reset();
    }
  }

  Future<void> forceLogout() async {
    await _reset();
  }

  Future<String> getTokenForGql() async {
    if (getGqlTokenFuture != null) {
      return getGqlTokenFuture!;
    }

    try {
      getGqlTokenFuture = _getTokenAndProcess();
      final result = await getGqlTokenFuture!;
      return result;
    } finally {
      getGqlTokenFuture = null;
    }
  }

  Future<String> _getTokenAndProcess() async {
    try {
      final session = await _getSession();
      if (session == null || !session.isValid) {
        await _processSessionState(Future.value(null));
        return '';
      } else {
        await _processSessionState(Future.value(session));
        return await _getSessionToken() ?? "";
      }
    } catch (e) {
      await _processSessionState(Future.value(null));
      return '';
    }
  }

  Future<void> _checkSessionState() async {
    await _processSessionState(_getSession());
  }

  Future<Session?> _getSession() async {
    final res = await _api.toSession(
      xSessionToken: await _getSessionToken() ?? "",
    );
    if (res.data == null) {
      return null;
    }
    return res.data;
  }

  Future<void> _processSessionState(
    Future<Session?> future,
  ) async {
    try {
      final session = await future;
      if (session == null || !session.isValid) {
        await _reset();
      } else {
        _updateSessionState(OrySessionState.valid);
      }
    } catch (e) {
      _reset();
    }
  }

  Future<void> _reset() async {
    await _deleteSessionToken();
    _updateSessionState(OrySessionState.invalid);
  }

  Future<void> _updateSessionState(OrySessionState newState) async {
    if (_sessionState != newState) {
      _sessionState = newState;
      _sessionStateStreamCtrl.add(newState);
    }
  }

  Future<String?> _getSessionToken() async {
    return await secureStorage.read(key: sessionStorageKey);
  }

  Future<void> _saveSessionToken(String sessionToken) async {
    await secureStorage.write(key: sessionStorageKey, value: sessionToken);
  }

  Future<void> _deleteSessionToken() async {
    await secureStorage.delete(key: sessionStorageKey);
  }
}

UpdateRegistrationFlowBody _createWalletSignupBody({
  required String signature,
  required String token,
  required String walletAddress,
}) {
  final password = _getPassword(walletAddress);
  final passwordMethod = UpdateRegistrationFlowWithPasswordMethod(
    (b) => b
      ..method = 'password'
      ..password = password
      ..traits = MapJsonObject({
        'wallet': walletAddress,
      })
      ..transientPayload = MapJsonObject({
        'wallet_signature': signature,
        'wallet_signature_token': token,
      }),
  );

  return UpdateRegistrationFlowBody(
    (b) => b
      ..oneOf = OneOfDynamic(
        typeIndex: 0,
        types: [
          UpdateRegistrationFlowWithPasswordMethod,
        ],
        value: passwordMethod,
      ),
  );
}

// Create a password-based login flow body
UpdateLoginFlowBody _createWalletLoginBody({
  required String signature,
  required String token,
  required String walletAddress,
}) {
  // Create the password method instance
  final passwordMethod = UpdateLoginFlowWithPasswordMethod(
    (b) => b
      ..method = 'password'
      ..identifier = walletAddress
      ..password = _getPassword(walletAddress)
      ..transientPayload = MapJsonObject({
        'wallet_signature': signature,
        'wallet_signature_token': token,
      }),
  );

  return UpdateLoginFlowBody(
    (b) => b
      ..oneOf = OneOfDynamic(
        typeIndex: 0,
        types: [
          UpdateLoginFlowWithPasswordMethod,
        ],
        value: passwordMethod,
      ),
  );
}

String _getPassword(String walletAddress) {
  return walletAddress.split('').reversed.join('');
}

extension SessionExtension on Session {
  bool get isExpired =>
      expiresAt != null && expiresAt!.isBefore(DateTime.now());
  bool get isValid => active == true && !isExpired;
}
