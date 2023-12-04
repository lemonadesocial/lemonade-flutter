import 'package:graphql_flutter/graphql_flutter.dart';

const configFragment = '''
  fragment configFields on Config {
    _id
    createdAt
    updatedAt
    avatar
    backstory
    description
    filter
    isPublic
    job
    modelName
    name
    openaiApiKey
    systemMessage
    temperature
    topP
    user
    userExpanded {
      _id
      name
      image_avatar
      __typename
    }
    welcomeMessage
    welcomeMetadata
    __typename
  }

''';

final getConfigDetail = gql('''
  $configFragment
  query config(\$id: ObjectId!) {
    config(_id: \$id) {
      ...configFields
      __typename
    }
  }
''');
