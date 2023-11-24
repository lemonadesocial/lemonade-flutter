import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/core/data/event/gql/event_query.dart';

final createEventMutation = gql('''
  $eventFragment
  mutation CreateEvent(\$input: EventInput!) {
    createEvent(input: \$input) {
      ...eventFields
    }
  }
''');
