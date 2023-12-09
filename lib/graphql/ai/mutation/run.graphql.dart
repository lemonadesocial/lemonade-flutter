import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Mutation$Run {
  factory Variables$Mutation$Run({
    required String message,
    required String config,
    String? session,
  }) =>
      Variables$Mutation$Run._({
        r'message': message,
        r'config': config,
        if (session != null) r'session': session,
      });

  Variables$Mutation$Run._(this._$data);

  factory Variables$Mutation$Run.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$message = data['message'];
    result$data['message'] = (l$message as String);
    final l$config = data['config'];
    result$data['config'] = (l$config as String);
    if (data.containsKey('session')) {
      final l$session = data['session'];
      result$data['session'] = (l$session as String?);
    }
    return Variables$Mutation$Run._(result$data);
  }

  Map<String, dynamic> _$data;

  String get message => (_$data['message'] as String);
  String get config => (_$data['config'] as String);
  String? get session => (_$data['session'] as String?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$message = message;
    result$data['message'] = l$message;
    final l$config = config;
    result$data['config'] = l$config;
    if (_$data.containsKey('session')) {
      final l$session = session;
      result$data['session'] = l$session;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$Run<Variables$Mutation$Run> get copyWith =>
      CopyWith$Variables$Mutation$Run(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$Run) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$config = config;
    final lOther$config = other.config;
    if (l$config != lOther$config) {
      return false;
    }
    final l$session = session;
    final lOther$session = other.session;
    if (_$data.containsKey('session') != other._$data.containsKey('session')) {
      return false;
    }
    if (l$session != lOther$session) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$config = config;
    final l$session = session;
    return Object.hashAll([
      l$message,
      l$config,
      _$data.containsKey('session') ? l$session : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$Run<TRes> {
  factory CopyWith$Variables$Mutation$Run(
    Variables$Mutation$Run instance,
    TRes Function(Variables$Mutation$Run) then,
  ) = _CopyWithImpl$Variables$Mutation$Run;

  factory CopyWith$Variables$Mutation$Run.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$Run;

  TRes call({
    String? message,
    String? config,
    String? session,
  });
}

class _CopyWithImpl$Variables$Mutation$Run<TRes>
    implements CopyWith$Variables$Mutation$Run<TRes> {
  _CopyWithImpl$Variables$Mutation$Run(
    this._instance,
    this._then,
  );

  final Variables$Mutation$Run _instance;

  final TRes Function(Variables$Mutation$Run) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? config = _undefined,
    Object? session = _undefined,
  }) =>
      _then(Variables$Mutation$Run._({
        ..._instance._$data,
        if (message != _undefined && message != null)
          'message': (message as String),
        if (config != _undefined && config != null)
          'config': (config as String),
        if (session != _undefined) 'session': (session as String?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$Run<TRes>
    implements CopyWith$Variables$Mutation$Run<TRes> {
  _CopyWithStubImpl$Variables$Mutation$Run(this._res);

  TRes _res;

  call({
    String? message,
    String? config,
    String? session,
  }) =>
      _res;
}

class Mutation$Run {
  Mutation$Run({
    required this.run,
    this.$__typename = 'Mutation',
  });

  factory Mutation$Run.fromJson(Map<String, dynamic> json) {
    final l$run = json['run'];
    final l$$__typename = json['__typename'];
    return Mutation$Run(
      run: Mutation$Run$run.fromJson((l$run as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$Run$run run;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$run = run;
    _resultData['run'] = l$run.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$run = run;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$run,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$Run) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$run = run;
    final lOther$run = other.run;
    if (l$run != lOther$run) {
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

extension UtilityExtension$Mutation$Run on Mutation$Run {
  CopyWith$Mutation$Run<Mutation$Run> get copyWith => CopyWith$Mutation$Run(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$Run<TRes> {
  factory CopyWith$Mutation$Run(
    Mutation$Run instance,
    TRes Function(Mutation$Run) then,
  ) = _CopyWithImpl$Mutation$Run;

  factory CopyWith$Mutation$Run.stub(TRes res) = _CopyWithStubImpl$Mutation$Run;

  TRes call({
    Mutation$Run$run? run,
    String? $__typename,
  });
  CopyWith$Mutation$Run$run<TRes> get run;
}

class _CopyWithImpl$Mutation$Run<TRes> implements CopyWith$Mutation$Run<TRes> {
  _CopyWithImpl$Mutation$Run(
    this._instance,
    this._then,
  );

  final Mutation$Run _instance;

  final TRes Function(Mutation$Run) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? run = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Run(
        run: run == _undefined || run == null
            ? _instance.run
            : (run as Mutation$Run$run),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Mutation$Run$run<TRes> get run {
    final local$run = _instance.run;
    return CopyWith$Mutation$Run$run(local$run, (e) => call(run: e));
  }
}

class _CopyWithStubImpl$Mutation$Run<TRes>
    implements CopyWith$Mutation$Run<TRes> {
  _CopyWithStubImpl$Mutation$Run(this._res);

  TRes _res;

  call({
    Mutation$Run$run? run,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Mutation$Run$run<TRes> get run =>
      CopyWith$Mutation$Run$run.stub(_res);
}

const documentNodeMutationRun = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'Run'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'message')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'config')),
        type: NamedTypeNode(
          name: NameNode(value: 'ObjectId'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'session')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'run'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'message'),
            value: VariableNode(name: NameNode(value: 'message')),
          ),
          ArgumentNode(
            name: NameNode(value: 'config'),
            value: VariableNode(name: NameNode(value: 'config')),
          ),
          ArgumentNode(
            name: NameNode(value: 'session'),
            value: VariableNode(name: NameNode(value: 'session')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'metadata'),
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
]);
Mutation$Run _parserFn$Mutation$Run(Map<String, dynamic> data) =>
    Mutation$Run.fromJson(data);
typedef OnMutationCompleted$Mutation$Run = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$Run?,
);

class Options$Mutation$Run extends graphql.MutationOptions<Mutation$Run> {
  Options$Mutation$Run({
    String? operationName,
    required Variables$Mutation$Run variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$Run? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$Run? onCompleted,
    graphql.OnMutationUpdate<Mutation$Run>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$Run(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRun,
          parserFn: _parserFn$Mutation$Run,
        );

  final OnMutationCompleted$Mutation$Run? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$Run
    extends graphql.WatchQueryOptions<Mutation$Run> {
  WatchOptions$Mutation$Run({
    String? operationName,
    required Variables$Mutation$Run variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$Run? typedOptimisticResult,
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
          document: documentNodeMutationRun,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$Run,
        );
}

extension ClientExtension$Mutation$Run on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$Run>> mutate$Run(
          Options$Mutation$Run options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$Run> watchMutation$Run(
          WatchOptions$Mutation$Run options) =>
      this.watchMutation(options);
}

class Mutation$Run$HookResult {
  Mutation$Run$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$Run runMutation;

  final graphql.QueryResult<Mutation$Run> result;
}

Mutation$Run$HookResult useMutation$Run([WidgetOptions$Mutation$Run? options]) {
  final result =
      graphql_flutter.useMutation(options ?? WidgetOptions$Mutation$Run());
  return Mutation$Run$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$Run> useWatchMutation$Run(
        WatchOptions$Mutation$Run options) =>
    graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$Run extends graphql.MutationOptions<Mutation$Run> {
  WidgetOptions$Mutation$Run({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$Run? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$Run? onCompleted,
    graphql.OnMutationUpdate<Mutation$Run>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$Run(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationRun,
          parserFn: _parserFn$Mutation$Run,
        );

  final OnMutationCompleted$Mutation$Run? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$Run = graphql.MultiSourceResult<Mutation$Run>
    Function(
  Variables$Mutation$Run, {
  Object? optimisticResult,
  Mutation$Run? typedOptimisticResult,
});
typedef Builder$Mutation$Run = widgets.Widget Function(
  RunMutation$Mutation$Run,
  graphql.QueryResult<Mutation$Run>?,
);

class Mutation$Run$Widget extends graphql_flutter.Mutation<Mutation$Run> {
  Mutation$Run$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$Run? options,
    required Builder$Mutation$Run builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$Run(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$Run$run {
  Mutation$Run$run({
    required this.message,
    required this.metadata,
    this.$__typename = 'RunResult',
  });

  factory Mutation$Run$run.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$metadata = json['metadata'];
    final l$$__typename = json['__typename'];
    return Mutation$Run$run(
      message: (l$message as String),
      metadata: (l$metadata as Map<String, dynamic>),
      $__typename: (l$$__typename as String),
    );
  }

  final String message;

  final Map<String, dynamic> metadata;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$message = message;
    _resultData['message'] = l$message;
    final l$metadata = metadata;
    _resultData['metadata'] = l$metadata;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$metadata = metadata;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$message,
      l$metadata,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$Run$run) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$metadata = metadata;
    final lOther$metadata = other.metadata;
    if (l$metadata != lOther$metadata) {
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

extension UtilityExtension$Mutation$Run$run on Mutation$Run$run {
  CopyWith$Mutation$Run$run<Mutation$Run$run> get copyWith =>
      CopyWith$Mutation$Run$run(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$Run$run<TRes> {
  factory CopyWith$Mutation$Run$run(
    Mutation$Run$run instance,
    TRes Function(Mutation$Run$run) then,
  ) = _CopyWithImpl$Mutation$Run$run;

  factory CopyWith$Mutation$Run$run.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Run$run;

  TRes call({
    String? message,
    Map<String, dynamic>? metadata,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$Run$run<TRes>
    implements CopyWith$Mutation$Run$run<TRes> {
  _CopyWithImpl$Mutation$Run$run(
    this._instance,
    this._then,
  );

  final Mutation$Run$run _instance;

  final TRes Function(Mutation$Run$run) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? metadata = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Run$run(
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        metadata: metadata == _undefined || metadata == null
            ? _instance.metadata
            : (metadata as Map<String, dynamic>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$Run$run<TRes>
    implements CopyWith$Mutation$Run$run<TRes> {
  _CopyWithStubImpl$Mutation$Run$run(this._res);

  TRes _res;

  call({
    String? message,
    Map<String, dynamic>? metadata,
    String? $__typename,
  }) =>
      _res;
}
