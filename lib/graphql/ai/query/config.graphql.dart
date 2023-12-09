import 'config_fragment.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$config {
  factory Variables$Query$config({required String id}) =>
      Variables$Query$config._({
        r'id': id,
      });

  Variables$Query$config._(this._$data);

  factory Variables$Query$config.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Query$config._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Query$config<Variables$Query$config> get copyWith =>
      CopyWith$Variables$Query$config(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$config) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Variables$Query$config<TRes> {
  factory CopyWith$Variables$Query$config(
    Variables$Query$config instance,
    TRes Function(Variables$Query$config) then,
  ) = _CopyWithImpl$Variables$Query$config;

  factory CopyWith$Variables$Query$config.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$config;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Query$config<TRes>
    implements CopyWith$Variables$Query$config<TRes> {
  _CopyWithImpl$Variables$Query$config(
    this._instance,
    this._then,
  );

  final Variables$Query$config _instance;

  final TRes Function(Variables$Query$config) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(Variables$Query$config._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$config<TRes>
    implements CopyWith$Variables$Query$config<TRes> {
  _CopyWithStubImpl$Variables$Query$config(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Query$config {
  Query$config({
    required this.config,
    this.$__typename = 'Query',
  });

  factory Query$config.fromJson(Map<String, dynamic> json) {
    final l$config = json['config'];
    final l$$__typename = json['__typename'];
    return Query$config(
      config:
          Fragment$ConfigFields.fromJson((l$config as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$ConfigFields config;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$config = config;
    _resultData['config'] = l$config.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$config = config;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$config,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$config) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$config = config;
    final lOther$config = other.config;
    if (l$config != lOther$config) {
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

extension UtilityExtension$Query$config on Query$config {
  CopyWith$Query$config<Query$config> get copyWith => CopyWith$Query$config(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$config<TRes> {
  factory CopyWith$Query$config(
    Query$config instance,
    TRes Function(Query$config) then,
  ) = _CopyWithImpl$Query$config;

  factory CopyWith$Query$config.stub(TRes res) = _CopyWithStubImpl$Query$config;

  TRes call({
    Fragment$ConfigFields? config,
    String? $__typename,
  });
  CopyWith$Fragment$ConfigFields<TRes> get config;
}

class _CopyWithImpl$Query$config<TRes> implements CopyWith$Query$config<TRes> {
  _CopyWithImpl$Query$config(
    this._instance,
    this._then,
  );

  final Query$config _instance;

  final TRes Function(Query$config) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? config = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$config(
        config: config == _undefined || config == null
            ? _instance.config
            : (config as Fragment$ConfigFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Fragment$ConfigFields<TRes> get config {
    final local$config = _instance.config;
    return CopyWith$Fragment$ConfigFields(local$config, (e) => call(config: e));
  }
}

class _CopyWithStubImpl$Query$config<TRes>
    implements CopyWith$Query$config<TRes> {
  _CopyWithStubImpl$Query$config(this._res);

  TRes _res;

  call({
    Fragment$ConfigFields? config,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Fragment$ConfigFields<TRes> get config =>
      CopyWith$Fragment$ConfigFields.stub(_res);
}

const documentNodeQueryconfig = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'config'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'id')),
        type: NamedTypeNode(
          name: NameNode(value: 'ObjectId'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'config'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: '_id'),
            value: VariableNode(name: NameNode(value: 'id')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'ConfigFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionConfigFields,
]);
Query$config _parserFn$Query$config(Map<String, dynamic> data) =>
    Query$config.fromJson(data);
typedef OnQueryComplete$Query$config = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$config?,
);

class Options$Query$config extends graphql.QueryOptions<Query$config> {
  Options$Query$config({
    String? operationName,
    required Variables$Query$config variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$config? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$config? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$config(data),
                  ),
          onError: onError,
          document: documentNodeQueryconfig,
          parserFn: _parserFn$Query$config,
        );

  final OnQueryComplete$Query$config? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$config
    extends graphql.WatchQueryOptions<Query$config> {
  WatchOptions$Query$config({
    String? operationName,
    required Variables$Query$config variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$config? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryconfig,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$config,
        );
}

class FetchMoreOptions$Query$config extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$config({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$config variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryconfig,
        );
}

extension ClientExtension$Query$config on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$config>> query$config(
          Options$Query$config options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$config> watchQuery$config(
          WatchOptions$Query$config options) =>
      this.watchQuery(options);
  void writeQuery$config({
    required Query$config data,
    required Variables$Query$config variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryconfig),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$config? readQuery$config({
    required Variables$Query$config variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryconfig),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$config.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$config> useQuery$config(
        Options$Query$config options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$config> useWatchQuery$config(
        WatchOptions$Query$config options) =>
    graphql_flutter.useWatchQuery(options);

class Query$config$Widget extends graphql_flutter.Query<Query$config> {
  Query$config$Widget({
    widgets.Key? key,
    required Options$Query$config options,
    required graphql_flutter.QueryBuilder<Query$config> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}
