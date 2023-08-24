import 'package:graphql_flutter/graphql_flutter.dart';

class Failure {
  Failure({this.message});

  factory Failure.withGqlException(OperationException? gqlException) {
    final gqlErrors = gqlException?.graphqlErrors ?? [];
    if (gqlErrors.isEmpty) {
      return Failure();
    }

    return Failure(message: gqlErrors.first.message);
  }
  final String? message;
}
