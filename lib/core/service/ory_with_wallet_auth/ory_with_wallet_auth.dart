import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ory_client/ory_client.dart';
import 'package:one_of/one_of.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

class OryWithWalletAuthService {
  final String baseUrl = 'https://kratos.staging.lemonade.social';
  late final OryClient _oryClient;
  late final FrontendApi _api;

  OryWithWalletAuthService() {
    _oryClient = OryClient(
      basePathOverride: baseUrl,
    );
    _api = _oryClient.getFrontendApi();
  }

  Future<SuccessfulNativeRegistration> signup({
    required String walletAddress,
    required String signature,
    required String token,
  }) async {
    final flowData = await _api.createNativeRegistrationFlow();
    if (flowData.data == null) {
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
    if (successNativeRegistration.data == null) {
      throw Exception(
        'Failed to register ${successNativeRegistration.statusMessage}',
      );
    }
    return successNativeRegistration.data!;
  }

  Future<(bool, Either<LoginFlow?, SuccessfulNativeLogin?>)> login({
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
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final loginFlow = standardSerializers.deserialize(
          e.response!.data,
          specifiedType: const FullType(LoginFlow),
        ) as LoginFlow?;
        loginResult = Left(loginFlow);
      } else {
        loginResult = const Left(null);
      }
      success = false;
    }
    return (success, loginResult);
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
