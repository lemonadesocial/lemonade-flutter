import 'package:graphql_flutter/graphql_flutter.dart';

final generateMatrixTokenMutation = gql('''
  mutation matrixToken {
    generateMatrixToken
  }
''');
