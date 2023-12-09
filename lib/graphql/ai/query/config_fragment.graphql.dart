import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$ConfigFields {
  Fragment$ConfigFields({
    required this.$_id,
    required this.createdAt,
    required this.updatedAt,
    this.avatar,
    required this.description,
    this.isPublic,
    required this.name,
    this.systemMessage,
    this.welcomeMessage,
    this.welcomeMetadata,
    this.$__typename = 'Config',
  });

  factory Fragment$ConfigFields.fromJson(Map<String, dynamic> json) {
    final l$$_id = json['_id'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$avatar = json['avatar'];
    final l$description = json['description'];
    final l$isPublic = json['isPublic'];
    final l$name = json['name'];
    final l$systemMessage = json['systemMessage'];
    final l$welcomeMessage = json['welcomeMessage'];
    final l$welcomeMetadata = json['welcomeMetadata'];
    final l$$__typename = json['__typename'];
    return Fragment$ConfigFields(
      $_id: (l$$_id as String),
      createdAt: (l$createdAt as String),
      updatedAt: (l$updatedAt as String),
      avatar: (l$avatar as String?),
      description: (l$description as String),
      isPublic: (l$isPublic as bool?),
      name: (l$name as String),
      systemMessage: (l$systemMessage as String?),
      welcomeMessage: (l$welcomeMessage as String?),
      welcomeMetadata: (l$welcomeMetadata as Map<String, dynamic>?),
      $__typename: (l$$__typename as String),
    );
  }

  final String $_id;

  final String createdAt;

  final String updatedAt;

  final String? avatar;

  final String description;

  final bool? isPublic;

  final String name;

  final String? systemMessage;

  final String? welcomeMessage;

  final Map<String, dynamic>? welcomeMetadata;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$_id = $_id;
    _resultData['_id'] = l$$_id;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt;
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = l$updatedAt;
    final l$avatar = avatar;
    _resultData['avatar'] = l$avatar;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$isPublic = isPublic;
    _resultData['isPublic'] = l$isPublic;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$systemMessage = systemMessage;
    _resultData['systemMessage'] = l$systemMessage;
    final l$welcomeMessage = welcomeMessage;
    _resultData['welcomeMessage'] = l$welcomeMessage;
    final l$welcomeMetadata = welcomeMetadata;
    _resultData['welcomeMetadata'] = l$welcomeMetadata;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$_id = $_id;
    final l$createdAt = createdAt;
    final l$updatedAt = updatedAt;
    final l$avatar = avatar;
    final l$description = description;
    final l$isPublic = isPublic;
    final l$name = name;
    final l$systemMessage = systemMessage;
    final l$welcomeMessage = welcomeMessage;
    final l$welcomeMetadata = welcomeMetadata;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$$_id,
      l$createdAt,
      l$updatedAt,
      l$avatar,
      l$description,
      l$isPublic,
      l$name,
      l$systemMessage,
      l$welcomeMessage,
      l$welcomeMetadata,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$ConfigFields) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$$_id = $_id;
    final lOther$$_id = other.$_id;
    if (l$$_id != lOther$$_id) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
      return false;
    }
    final l$avatar = avatar;
    final lOther$avatar = other.avatar;
    if (l$avatar != lOther$avatar) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$isPublic = isPublic;
    final lOther$isPublic = other.isPublic;
    if (l$isPublic != lOther$isPublic) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$systemMessage = systemMessage;
    final lOther$systemMessage = other.systemMessage;
    if (l$systemMessage != lOther$systemMessage) {
      return false;
    }
    final l$welcomeMessage = welcomeMessage;
    final lOther$welcomeMessage = other.welcomeMessage;
    if (l$welcomeMessage != lOther$welcomeMessage) {
      return false;
    }
    final l$welcomeMetadata = welcomeMetadata;
    final lOther$welcomeMetadata = other.welcomeMetadata;
    if (l$welcomeMetadata != lOther$welcomeMetadata) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$ConfigFields on Fragment$ConfigFields {
  CopyWith$Fragment$ConfigFields<Fragment$ConfigFields> get copyWith =>
      CopyWith$Fragment$ConfigFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$ConfigFields<TRes> {
  factory CopyWith$Fragment$ConfigFields(
    Fragment$ConfigFields instance,
    TRes Function(Fragment$ConfigFields) then,
  ) = _CopyWithImpl$Fragment$ConfigFields;

  factory CopyWith$Fragment$ConfigFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$ConfigFields;

  TRes call({
    String? $_id,
    String? createdAt,
    String? updatedAt,
    String? avatar,
    String? description,
    bool? isPublic,
    String? name,
    String? systemMessage,
    String? welcomeMessage,
    Map<String, dynamic>? welcomeMetadata,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$ConfigFields<TRes>
    implements CopyWith$Fragment$ConfigFields<TRes> {
  _CopyWithImpl$Fragment$ConfigFields(
    this._instance,
    this._then,
  );

  final Fragment$ConfigFields _instance;

  final TRes Function(Fragment$ConfigFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $_id = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
    Object? avatar = _undefined,
    Object? description = _undefined,
    Object? isPublic = _undefined,
    Object? name = _undefined,
    Object? systemMessage = _undefined,
    Object? welcomeMessage = _undefined,
    Object? welcomeMetadata = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$ConfigFields(
        $_id: $_id == _undefined || $_id == null
            ? _instance.$_id
            : ($_id as String),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as String),
        updatedAt: updatedAt == _undefined || updatedAt == null
            ? _instance.updatedAt
            : (updatedAt as String),
        avatar: avatar == _undefined ? _instance.avatar : (avatar as String?),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        isPublic:
            isPublic == _undefined ? _instance.isPublic : (isPublic as bool?),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        systemMessage: systemMessage == _undefined
            ? _instance.systemMessage
            : (systemMessage as String?),
        welcomeMessage: welcomeMessage == _undefined
            ? _instance.welcomeMessage
            : (welcomeMessage as String?),
        welcomeMetadata: welcomeMetadata == _undefined
            ? _instance.welcomeMetadata
            : (welcomeMetadata as Map<String, dynamic>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$ConfigFields<TRes>
    implements CopyWith$Fragment$ConfigFields<TRes> {
  _CopyWithStubImpl$Fragment$ConfigFields(this._res);

  TRes _res;

  call({
    String? $_id,
    String? createdAt,
    String? updatedAt,
    String? avatar,
    String? description,
    bool? isPublic,
    String? name,
    String? systemMessage,
    String? welcomeMessage,
    Map<String, dynamic>? welcomeMetadata,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionConfigFields = FragmentDefinitionNode(
  name: NameNode(value: 'ConfigFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'Config'),
    isNonNull: false,
  )),
  directives: [],
  selectionSet: SelectionSetNode(selections: [
    FieldNode(
      name: NameNode(value: '_id'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'createdAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'updatedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'avatar'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'description'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'isPublic'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'name'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'systemMessage'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'welcomeMessage'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'welcomeMetadata'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: '__typename'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
  ]),
);
const documentNodeFragmentConfigFields = DocumentNode(definitions: [
  fragmentDefinitionConfigFields,
]);

extension ClientExtension$Fragment$ConfigFields on graphql.GraphQLClient {
  void writeFragment$ConfigFields({
    required Fragment$ConfigFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) =>
      this.writeFragment(
        graphql.FragmentRequest(
          idFields: idFields,
          fragment: const graphql.Fragment(
            fragmentName: 'ConfigFields',
            document: documentNodeFragmentConfigFields,
          ),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Fragment$ConfigFields? readFragment$ConfigFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'ConfigFields',
          document: documentNodeFragmentConfigFields,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$ConfigFields.fromJson(result);
  }
}
