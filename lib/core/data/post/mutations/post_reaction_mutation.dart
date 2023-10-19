import 'package:graphql_flutter/graphql_flutter.dart';

final togglePostReactionMutation = gql('''
  mutation toggleReaction(\$input: ReactionInput!) {
    toggleReaction(input: \$input)
  }
''');
