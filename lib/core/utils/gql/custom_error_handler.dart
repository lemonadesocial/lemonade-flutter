// ignore_for_file: constant_identifier_names

import 'package:app/core/config.dart';
import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLErrorCodeStrings {
  static const String GRAPHQL_PARSE_FAILED = "GRAPHQL_PARSE_FAILED";
  static const String GRAPHQL_VALIDATION_FAILED = "GRAPHQL_VALIDATION_FAILED";
  static const String BAD_USER_INPUT = "BAD_USER_INPUT";
  static const String PERSISTED_QUERY_NOT_FOUND = "PERSISTED_QUERY_NOT_FOUND";
  static const String PERSISTED_QUERY_NOT_SUPPORTED =
      "PERSISTED_QUERY_NOT_SUPPORTED";
  static const String OPERATION_RESOLUTION_FAILURE =
      "OPERATION_RESOLUTION_FAILURE";
  static const String BAD_REQUEST = "BAD_REQUEST";
  static const String INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR";
  static const String UNKNOWN_ERROR = "UNKNOWN_ERROR";
  static const String UNAUTHENTICATED = "UNAUTHENTICATED";
  static const String FORBIDDEN = "FORBIDDEN";
}

class CustomErrorHandler {
  static String getErrorMessage(List<GraphQLError>? errors) {
    var errorMessage = "";
    if (errors != null && errors.isNotEmpty) {
      var error = errors[0]; // Get the first error in the list
      errorMessage = error.message;
    }
    return errorMessage;
  }

  static String getFirstErrorCode(List<GraphQLError>? errors) {
    var errorCode = GraphQLErrorCodeStrings.UNKNOWN_ERROR;
    if (errors != null && errors.isNotEmpty) {
      try {
        var error = errors[0]; // Get the first error in the list
        errorCode = error.extensions!['code'];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return errorCode;
  }

  static handleExceptionError(
    Request request,
    NextLink forward,
    LinkException exception,
  ) {
    if (kDebugMode) {
      print('--- handleExceptionError request: ${request.toString()}');
      print('--- handleExceptionError exception : ${exception.toString()}');
    }
    // If server exception problem
    if (exception is ServerException) {
      final errors = exception.parsedResponse?.errors;
      final errorCode = getFirstErrorCode(errors);
      final errorMessage = getErrorMessage(errors);
      showSnackbarError(errorCode, errorMessage);
      if (errorCode == GraphQLErrorCodeStrings.INTERNAL_SERVER_ERROR) {
        CrashAnalyticsManager()
            .crashAnalyticsService
            ?.captureMessage(errorMessage, errors);
      }
    }
    return null;
  }

  static handleGraphQLError(
    Request request,
    NextLink forward,
    Response response,
  ) {
    final errors = response.errors;
    final errorCode = getFirstErrorCode(errors);
    final errorMessage = getErrorMessage(errors);

    if (kDebugMode) {
      print('--- handleGraphQLError request: ${request.toString()}');
      print('--- handleGraphQLError response : ${response.toString()}');
    }
    // TODO: temp solution to prevent show 401 error to user when logged out
    // the root cause is query widget still called when loggedout
    final unauthenticatedErrorAfterLogout =
        errorCode == GraphQLErrorCodeStrings.UNAUTHENTICATED &&
            getIt<AppOauth>().tokenState != OAuthTokenState.valid;

    if (!unauthenticatedErrorAfterLogout) {
      showSnackbarError(errorCode, errorMessage);
      CrashAnalyticsManager().crashAnalyticsService?.captureMessage(
        errors?.map((e) => e.toString()).join('\n') ?? '',
        [StackTrace.fromString(request.toString())],
      );
    }
    return null;
  }

  static void showSnackbarError(
    String errorCode,
    String errorMessage,
  ) {
    final errorMessageContent = AppConfig.isProduction
        ? errorMessage
        : "Code: $errorCode, $errorMessage";
    SnackBarUtils.showError(message: errorMessageContent);
    return;
  }
}
