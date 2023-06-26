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

final getUserQuery = gql('''
  ${baseUserFragment}
  query(\$id: MongoID, \$username: String, \$matrix_localpart: String) {
    getUser(_id: \$id, username: \$username, matrix_localpart: \$matrix_localpart) {
      ...baseUserFragment
    }
}
''');