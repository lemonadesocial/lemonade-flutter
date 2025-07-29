import 'package:app/core/service/ory_auth/ory_auth.dart';
import 'package:dio/dio.dart';
import 'package:ory_client/ory_client.dart';
import 'package:one_of/one_of.dart';
import 'package:collection/collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

extension OryVerifyEmailExtension on OryAuth {
  (String?, String?) _handleVefificationFlowError(DioException e) {
    if (e.response?.data != null) {
      if (e.response?.statusCode == 200) {
        final flowId = e.response!.realUri.queryParameters['flow'] ?? '';
        return (flowId, null);
      }

      if (e.response?.statusCode == 400) {
        try {
          final verificationFlow = standardSerializers.deserialize(
            e.response!.data,
            specifiedType: const FullType(VerificationFlow),
          ) as VerificationFlow?;
          return (
            null,
            verificationFlow?.ui.messages
                ?.firstWhereOrNull(
                  (message) => message.type == UiTextTypeEnum.error,
                )
                ?.text
          );
        } catch (e) {
          return (null, e.toString());
        }
      }

      return (null, e.response?.statusMessage);
    }
    return (null, e.toString());
  }

  Future<(String?, String?)> verifyEmail(String email) async {
    String? errorMessage;
    try {
      final flow = await api.createNativeSettingsFlow(
        xSessionToken: await getSessionToken() ?? "",
      );
      if (flow.data == null) {
        throw Exception('Failed to create verification flow');
      }
      await api.updateSettingsFlow(
        xSessionToken: await getSessionToken() ?? "",
        flow: flow.data!.id,
        updateSettingsFlowBody: UpdateSettingsFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateSettingsFlowWithProfileMethod],
              value: UpdateSettingsFlowWithProfileMethod(
                (b) => b
                  ..csrfToken = ''
                  ..method = 'profile'
                  ..traits = MapJsonObject(
                    {
                      'email': email,
                      ...(flow.data?.identity.traits?.asMap ?? {}),
                    },
                  ),
              ),
            ),
        ),
      );
      final verificationFlowResult = await api.createNativeVerificationFlow();
      if (verificationFlowResult.data == null) {
        throw Exception('Failed to create verification flow');
      }
      VerificationFlow? verificationFlow = verificationFlowResult.data!;

      verificationFlow = (await api.updateVerificationFlow(
        flow: verificationFlow.id,
        updateVerificationFlowBody: UpdateVerificationFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateVerificationFlowWithCodeMethod],
              value: UpdateVerificationFlowWithCodeMethod(
                (b) => b
                  ..csrfToken = ''
                  ..method = UpdateVerificationFlowWithCodeMethodMethodEnum.code
                  ..email = email,
              ),
            ),
        ),
      ))
          .data;
      if (verificationFlow == null) {
        throw Exception('Failed to update verification flow');
      }
      final codeSent = verificationFlow.state?.asString == 'sent_email';
      if (codeSent) {
        return (verificationFlow.id, null);
      }
      errorMessage = verificationFlow.ui.messages
          ?.firstWhereOrNull(
            (message) => message.type == UiTextTypeEnum.error,
          )
          ?.text;
      return (null, errorMessage ?? 'Failed to verify email');
    } catch (e) {
      if (e is DioException) {
        return _handleVefificationFlowError(e);
      }
      return (null, e.toString());
    }
  }

  Future<(String?, String?)> verifyEmailWithCode({
    required String email,
    required String code,
    required String flowId,
  }) async {
    try {
      final updateVerificationFlow = await api.updateVerificationFlow(
        flow: flowId,
        updateVerificationFlowBody: UpdateVerificationFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateVerificationFlowWithCodeMethod],
              value: UpdateVerificationFlowWithCodeMethod(
                (b) => b
                  ..csrfToken = ''
                  ..method = UpdateVerificationFlowWithCodeMethodMethodEnum.code
                  ..email = email
                  ..code = code,
              ),
            ),
        ),
      );
      if (updateVerificationFlow.data == null) {
        throw Exception('Failed to update verification flow');
      }
      return (updateVerificationFlow.data?.id, null);
    } catch (e) {
      if (e is DioException) {
        return _handleVefificationFlowError(e);
      }
      return (null, e.toString());
    }
  }

  Future<String?> resendEmailVerification({
    required String email,
    required String flowId,
    required Function() onCodeSent,
  }) async {
    try {
      final updateVerificationFlow = await api.updateVerificationFlow(
        flow: flowId,
        updateVerificationFlowBody: UpdateVerificationFlowBody(
          (b) => b
            ..oneOf = OneOfDynamic(
              typeIndex: 0,
              types: [UpdateVerificationFlowWithCodeMethod],
              value: UpdateVerificationFlowWithCodeMethod(
                (b) => b
                  ..csrfToken = ''
                  ..method = UpdateVerificationFlowWithCodeMethodMethodEnum.code
                  ..email = email,
              ),
            ),
        ),
      );
      final codeSent =
          updateVerificationFlow.data?.state?.asString == 'sent_email';
      if (codeSent) {
        onCodeSent();
      }
      return null;
    } catch (e) {
      if (e is DioException) {
        final (flowId, errorMessage) = _handleVefificationFlowError(e);
        if (flowId != null) {
          onCodeSent();
          return null;
        }
        return errorMessage;
      }
      return e.toString();
    }
  }
}
