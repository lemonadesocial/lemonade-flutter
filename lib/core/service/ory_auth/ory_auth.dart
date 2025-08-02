import 'package:app/core/config.dart';
import 'package:app/core/service/storage/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:collection/collection.dart';
import 'package:url_launcher/url_launcher.dart';
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
  late final FrontendApi api;
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
    api = _oryClient.getFrontendApi();
  }

  Future<SuccessfulNativeRegistration> signupWithWallet({
    required String walletAddress,
    required String signature,
    required String token,
  }) async {
    final flowData = await api.createNativeRegistrationFlow();
    if (flowData.data == null) {
      await _reset();
      throw Exception('Failed to create login flow');
    }

    final updateSignupBody = _createWalletSignupBody(
      signature: signature,
      token: token,
      walletAddress: walletAddress,
    );
    final successNativeRegistration = await api.updateRegistrationFlow(
      flow: flowData.data!.id,
      updateRegistrationFlowBody: updateSignupBody,
    );
    await _saveSessionToken(successNativeRegistration.data!.sessionToken ?? "");
    await _processSessionState(getSession());
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
      final flowData = await api.createNativeLoginFlow();
      if (flowData.data == null) {
        throw Exception('Failed to create login flow');
      }

      final updateLoginFlowBody = _createWalletLoginBody(
        signature: signature,
        token: token,
        walletAddress: walletAddress,
      );

      final successNativeLogin = await api.updateLoginFlow(
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
      await _processSessionState(getSession());
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

  Future<void> tryLoginWithCode({
    required String email,
    required Function(SuccessfulNativeLogin) onSuccess,
    required Function() onAccountNotExists,
    required Function(LoginFlow) onCodeSent,
  }) async {
    try {
      final flowData = (await api.createNativeLoginFlow()).data;
      if (flowData == null) {
        throw Exception('Failed to create login flow');
      }
      final loginFlowBody = UpdateLoginFlowWithCodeMethod(
        (b) => b
          ..method = 'code'
          ..csrfToken = ''
          ..identifier = email,
      );
      final successNativeLogin = await api.updateLoginFlow(
        flow: flowData.id,
        updateLoginFlowBody: UpdateLoginFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateLoginFlowWithCodeMethod],
              value: loginFlowBody,
            ),
        ),
      );
      if (successNativeLogin.data == null) {
        throw Exception(
          'Failed to update login flow ${successNativeLogin.statusMessage}',
        );
      }
      await _saveSessionToken(successNativeLogin.data!.sessionToken ?? "");
      await _processSessionState(getSession());
      onSuccess(successNativeLogin.data!);
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final loginFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(LoginFlow),
        ) as LoginFlow?;
        final accountNotExists = loginFlow?.ui.messages?.firstWhereOrNull(
              (message) => message.id == 4000035,
            ) !=
            null;
        if (accountNotExists) {
          await onAccountNotExists();
          return;
        }

        final codeSent = loginFlow?.state?.asString == 'sent_email';
        if (codeSent) {
          await onCodeSent(loginFlow!);
        }
      }
    }
  }

  Future<(SuccessfulNativeLogin?, String?)> loginWithCode({
    required String email,
    required String code,
    required String flowId,
  }) async {
    SuccessfulNativeLogin? loginResult;
    String? errorMessage;
    try {
      final loginFlowBody = UpdateLoginFlowWithCodeMethod(
        (b) => b
          ..method = 'code'
          ..code = code
          ..csrfToken = ''
          ..identifier = email,
      );
      final successNativeLogin = await api.updateLoginFlow(
        flow: flowId,
        updateLoginFlowBody: UpdateLoginFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateLoginFlowWithCodeMethod],
              value: loginFlowBody,
            ),
        ),
      );
      if (successNativeLogin.data == null) {
        throw Exception(
          'Failed to update login flow ${successNativeLogin.statusMessage}',
        );
      }
      loginResult = successNativeLogin.data!;
      await _saveSessionToken(successNativeLogin.data!.sessionToken ?? "");
      await _processSessionState(getSession());
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final loginFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(LoginFlow),
        ) as LoginFlow?;
        errorMessage = loginFlow?.ui.messages
            ?.firstWhereOrNull(
              (message) => message.type == UiTextTypeEnum.error,
            )
            ?.text;
      }
      await _reset();
    }
    return (loginResult, errorMessage);
  }

  Future<void> trySignupWithCode({
    required String email,
    required Function(SuccessfulNativeRegistration) onSuccess,
    required Function(RegistrationFlow) onCodeSent,
  }) async {
    try {
      final flowData = (await api.createNativeRegistrationFlow()).data;
      if (flowData == null) {
        throw Exception('Failed to create registration flow');
      }
      final signupFlowBody = UpdateRegistrationFlowWithCodeMethod(
        (b) => b
          ..method = 'code'
          ..csrfToken = ''
          ..traits = MapJsonObject({
            'email': email,
          }),
      );
      final successNativeSignup = await api.updateRegistrationFlow(
        flow: flowData.id,
        updateRegistrationFlowBody: UpdateRegistrationFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateRegistrationFlowWithCodeMethod],
              value: signupFlowBody,
            ),
        ),
      );
      if (successNativeSignup.data == null) {
        throw Exception(
          'Failed to update registration flow ${successNativeSignup.statusMessage}',
        );
      }
      await _saveSessionToken(successNativeSignup.data!.sessionToken ?? "");
      await _processSessionState(getSession());
      onSuccess(successNativeSignup.data!);
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final registrationFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(RegistrationFlow),
        ) as RegistrationFlow?;
        final codeSent = registrationFlow?.state?.asString == 'sent_email';
        if (codeSent) {
          await onCodeSent(registrationFlow!);
        }
      }
    }
  }

  Future<(SuccessfulNativeRegistration?, String?)> signupWithCode({
    required String email,
    required String code,
    required String flowId,
  }) async {
    SuccessfulNativeRegistration? signupResult;
    String? errorMessage;
    try {
      final signupFlowBody = UpdateRegistrationFlowWithCodeMethod(
        (b) => b
          ..method = 'code'
          ..code = code
          ..csrfToken = ''
          ..traits = MapJsonObject(
            {
              'email': email,
            },
          ),
      );

      final successNativeSignup = await api.updateRegistrationFlow(
        flow: flowId,
        updateRegistrationFlowBody: UpdateRegistrationFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateRegistrationFlowWithCodeMethod],
              value: signupFlowBody,
            ),
        ),
      );
      if (successNativeSignup.data == null) {
        throw Exception(
          'Failed to update registration flow ${successNativeSignup.statusMessage}',
        );
      }
      signupResult = successNativeSignup.data!;
      await _saveSessionToken(successNativeSignup.data!.sessionToken ?? "");
      await _processSessionState(getSession());
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final registrationFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(RegistrationFlow),
        ) as RegistrationFlow?;
        errorMessage = registrationFlow?.ui.messages
            ?.firstWhereOrNull(
              (message) => message.type == UiTextTypeEnum.error,
            )
            ?.text;
      }
      signupResult = null;
      await _reset();
    }
    return (signupResult, errorMessage);
  }

  Future<void> resendCode({
    required String email,
    required String flowId,
    bool isSignup = false,
    required Function() onCodeSentSuccess,
  }) async {
    try {
      //-- this should always throw an error
      isSignup
          ? await api.updateRegistrationFlow(
              flow: flowId,
              updateRegistrationFlowBody: UpdateRegistrationFlowBody(
                (b) => b
                  ..oneOf = OneOfDynamic(
                    typeIndex: 0,
                    types: [UpdateRegistrationFlowWithCodeMethod],
                    value: UpdateRegistrationFlowWithCodeMethod(
                      (b) => b
                        ..method = 'code'
                        ..resend = 'code'
                        ..csrfToken = ''
                        ..traits = MapJsonObject({
                          'email': email,
                        }),
                    ),
                  ),
              ),
            )
          : await api.updateLoginFlow(
              flow: flowId,
              updateLoginFlowBody: UpdateLoginFlowBody(
                (b) => b
                  ..oneOf = OneOfDynamic(
                    typeIndex: 0,
                    types: [UpdateLoginFlowWithCodeMethod],
                    value: UpdateLoginFlowWithCodeMethod(
                      (b) => b
                        ..resend = 'code'
                        ..method = 'code'
                        ..csrfToken = ''
                        ..identifier = email,
                    ),
                  ),
              ),
            );
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        bool codeSent = false;
        if (isSignup) {
          final registrationFlow = standardSerializers.deserialize(
            e.response!.data,
            specifiedType: const FullType(RegistrationFlow),
          ) as RegistrationFlow?;
          codeSent = registrationFlow?.state?.asString == 'sent_email';
        } else {
          final loginFlow = standardSerializers.deserialize(
            e.response!.data,
            specifiedType: const FullType(LoginFlow),
          ) as LoginFlow?;
          codeSent = loginFlow?.state?.asString == 'sent_email';
        }
        if (codeSent) {
          await onCodeSentSuccess();
        }
      }
    }
  }

  Future<(bool, String?)> loginWithOidc({
    required String provider,
    required String idToken,
    String? idTokenNonce,
    required Function() onAccountNotExists,
  }) async {
    try {
      final flow = await api.createNativeLoginFlow();
      if (flow.data == null) {
        throw Exception('Failed to create login flow');
      }
      final loginFlowBody = UpdateLoginFlowWithOidcMethod(
        (b) => b
          ..method = 'oidc'
          ..provider = provider
          ..idToken = idToken
          ..idTokenNonce = idTokenNonce,
      );
      final successNativeLogin = await api.updateLoginFlow(
        flow: flow.data!.id,
        updateLoginFlowBody: UpdateLoginFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateLoginFlowWithOidcMethod],
              value: loginFlowBody,
            ),
        ),
      );
      if (successNativeLogin.data == null) {
        throw Exception(
          'Failed to update login flow ${successNativeLogin.statusMessage}',
        );
      }
      await _saveSessionToken(successNativeLogin.data!.sessionToken ?? "");
      await _processSessionState(getSession());
      return (true, null);
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        if (e.response?.statusCode == 200) {
          if (e.response?.redirects.isNotEmpty == true) {
            launchUrl(e.response!.redirects.first.location);
          }
          return (false, null);
        }
        if (e.response?.statusCode != 400) {
          return (false, e.response?.statusMessage);
        }
        final loginFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(LoginFlow),
        ) as LoginFlow?;
        final accountNotExists = loginFlow?.ui.messages?.firstWhereOrNull(
              (message) => message.id == 4000035,
            ) !=
            null;
        if (accountNotExists) {
          await onAccountNotExists();
          return (false, null);
        }
        final errorMessage = loginFlow?.ui.messages
            ?.firstWhereOrNull(
              (message) => message.type == UiTextTypeEnum.error,
            )
            ?.text;
        return (false, errorMessage);
      }
      return (false, e.toString());
    }
  }

  Future<(bool, String?)> signupWithOidc({
    required String provider,
    required String idToken,
    String? idTokenNonce,
  }) async {
    try {
      final flow = await api.createNativeRegistrationFlow();
      if (flow.data == null) {
        throw Exception('Failed to create registration flow');
      }
      final signupFlowBody = UpdateRegistrationFlowWithOidcMethod(
        (b) => b
          ..method = 'oidc'
          ..provider = provider
          ..csrfToken = ''
          ..idToken = idToken
          ..idTokenNonce = idTokenNonce,
      );
      final successNativeSignup = await api.updateRegistrationFlow(
        flow: flow.data!.id,
        updateRegistrationFlowBody: UpdateRegistrationFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateRegistrationFlowWithOidcMethod],
              value: signupFlowBody,
            ),
        ),
      );
      if (successNativeSignup.data == null) {
        throw Exception(
          'Failed to update registration flow ${successNativeSignup.statusMessage}',
        );
      }
      await _saveSessionToken(successNativeSignup.data!.sessionToken ?? "");
      await _processSessionState(getSession());
      return (true, null);
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        if (e.response?.statusCode == 200) {
          if (e.response?.redirects.isNotEmpty == true) {
            launchUrl(e.response!.redirects.first.location);
          }
          return (false, null);
        }
        if (e.response?.statusCode != 400) {
          return (false, e.response?.statusMessage);
        }

        final registrationFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(RegistrationFlow),
        ) as RegistrationFlow?;
        final errorMessage = registrationFlow?.ui.messages
            ?.firstWhereOrNull(
              (message) => message.type == UiTextTypeEnum.error,
            )
            ?.text;
        return (false, errorMessage);
      }
      return (false, e.toString());
    }
  }

  Future<void> logout() async {
    final sessionToken = await getSessionToken();
    final response = await api.performNativeLogout(
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
      final session = await getSession();
      if (session == null || !session.isValid) {
        await _processSessionState(Future.value(null));
        return '';
      } else {
        await _processSessionState(Future.value(session));
        return await getSessionToken() ?? "";
      }
    } catch (e) {
      await _processSessionState(Future.value(null));
      return '';
    }
  }

  Future<void> _checkSessionState() async {
    await _processSessionState(getSession());
  }

  Future<Session?> getSession() async {
    final res = await api.toSession(
      xSessionToken: await getSessionToken() ?? "",
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

  Future<String?> getSessionToken() async {
    return await secureStorage.read(key: sessionStorageKey);
  }

  Future<void> _saveSessionToken(String sessionToken) async {
    await secureStorage.write(key: sessionStorageKey, value: sessionToken);
  }

  Future<void> _deleteSessionToken() async {
    await secureStorage.delete(key: sessionStorageKey);
  }
}

const _dummyPassword = '!!dummy-WALLET-password@@';

UpdateRegistrationFlowBody _createWalletSignupBody({
  required String signature,
  required String token,
  required String walletAddress,
}) {
  final passwordMethod = UpdateRegistrationFlowWithPasswordMethod(
    (b) => b
      ..method = 'password'
      ..password = _dummyPassword
      ..csrfToken = ''
      ..traits = MapJsonObject({
        'wallet': walletAddress.toLowerCase(),
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
      ..identifier = walletAddress.toLowerCase()
      ..csrfToken = ''
      ..password = _dummyPassword
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

extension SessionExtension on Session {
  bool get isExpired =>
      expiresAt != null && expiresAt!.isBefore(DateTime.now());
  bool get isValid => active == true && !isExpired;
}
