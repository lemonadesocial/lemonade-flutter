import 'package:graphql_flutter/graphql_flutter.dart';

final watchVotingUpdatedSubscription = gql('''
  subscription VotingUpdated(\$id: MongoID!) {
    votingUpdated(_id: \$id)
  }
''');
