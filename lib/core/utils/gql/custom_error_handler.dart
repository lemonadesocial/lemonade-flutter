// ignore_for_file: constant_identifier_names

import 'package:app/core/config.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
      print('handleGraphQhandleExceptionErrorError : ${exception.toString()}');
    }
    // If server exception problem
    if (exception is ServerException) {
      final errors = exception.parsedResponse?.errors;
      final errorCode = getFirstErrorCode(errors);
      final errorMessage = getErrorMessage(errors);
      showSnackbarError(errorCode, errorMessage);
    }
    FirebaseCrashlytics.instance.log(exception.toString());
    return null;
  }

  static handleGraphQLError(
    Request request,
    NextLink forward,
    Response response,
  ) {
    if (kDebugMode) {
      print('handleGraphQLError : ${response.errors.toString()}');
    }
    final errors = response.errors;
    final errorCode = getFirstErrorCode(errors);
    final errorMessage = getErrorMessage(errors);
    showSnackbarError(errorCode, errorMessage);
    FirebaseCrashlytics.instance.log(response.errors.toString());
    return null;
  }

  static void showSnackbarError(
    String errorCode,
    String errorMessage,
  ) {
    String message;
    // If production, show meaningful error message
    if (AppConfig.isProduction) {
      switch (errorCode) {
        case GraphQLErrorCodeStrings.GRAPHQL_PARSE_FAILED:
          message = "Syntax error. Please try again.";
          break;
        case GraphQLErrorCodeStrings.GRAPHQL_VALIDATION_FAILED:
          message = "Invalid request. Please check and try again later.";
          break;
        case GraphQLErrorCodeStrings.BAD_USER_INPUT:
          message = "Invalid input. Please review and try again later.";
          break;
        case GraphQLErrorCodeStrings.PERSISTED_QUERY_NOT_FOUND:
          message = "Request not found. Please try again later.";
          break;
        case GraphQLErrorCodeStrings.PERSISTED_QUERY_NOT_SUPPORTED:
          message = "Request not supported. Please try again later.";
          break;
        case GraphQLErrorCodeStrings.OPERATION_RESOLUTION_FAILURE:
          message = "Request issue. Please try again later.";
          break;
        case GraphQLErrorCodeStrings.BAD_REQUEST:
          message = "Request problem. Please try again later.";
          break;
        case GraphQLErrorCodeStrings.INTERNAL_SERVER_ERROR:
          message = "Internal server error. Please try again later.";
          break;
        default:
          message = "Oops! Something went wrong. Please try again later.";
          break;
      }
      SnackBarUtils.showErrorSnackbar(
        errorMessage.isNotEmpty ? errorMessage : message,
      );
      return;
    }
    // Show detail error code and error message in Staging and development
    SnackBarUtils.showErrorSnackbar("Code: $errorCode, $errorMessage");
    return;
  }
}
