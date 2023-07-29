import 'dart:io';

import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';

import 'uia_request_manager.dart';

extension LocalizedExceptionExtension on Object {
  String toLocalizedString(BuildContext context) {
    final t = Translations.of(context);
    if (this is MatrixException) {
      switch ((this as MatrixException).error) {
        case MatrixError.M_FORBIDDEN:
          return t.matrix.noPermission;
        case MatrixError.M_LIMIT_EXCEEDED:
          return t.matrix.tooManyRequestsWarning;
        default:
          return (this as MatrixException).errorMessage;
      }
    }
    if (this is FileTooBigMatrixException) {
      return t.matrix.fileIsTooBigForServer;
    }
    if (this is BadServerVersionsException) {
      final serverVersions = (this as BadServerVersionsException)
          .serverVersions
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      final supportedVersions = (this as BadServerVersionsException)
          .supportedVersions
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      return t.matrix.badServerVersionsException(
        serverVersions: serverVersions,
        supportedVersions: supportedVersions,
      );
    }
    if (this is BadServerLoginTypesException) {
      final serverVersions = (this as BadServerLoginTypesException)
          .serverLoginTypes
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      final supportedVersions = (this as BadServerLoginTypesException)
          .supportedLoginTypes
          .toString()
          .replaceAll('{', '"')
          .replaceAll('}', '"');
      return t.matrix.badServerLoginTypesException(
        serverVersions: serverVersions,
        supportedVersions: supportedVersions,
      );
    }
    if (this is MatrixConnectionException || this is SocketException) {
      return t.matrix.noConnectionToTheServer;
    }
    if (this is String) return toString();
    if (this is UiaException) return toString();
    Logs().w('Something went wrong: ', this);
    return t.matrix.oopsSomethingWentWrong;
  }
}
