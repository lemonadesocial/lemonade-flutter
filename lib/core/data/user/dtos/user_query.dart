import 'package:graphql_flutter/graphql_flutter.dart';

final baseUserFragment = '''
  fragment baseUserFragment on User {
  _id
  name
  username
  new_photos
  image_avatar
}
''';

final getMeQuery = gql('''
  ${baseUserFragment}
  query() {
    getMe() {
      ...baseUserFragment
    }
}
''');