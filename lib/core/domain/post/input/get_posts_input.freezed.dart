// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_posts_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetPostsInput _$GetPostsInputFromJson(Map<String, dynamic> json) {
  return _GetPostsInput.fromJson(json);
}

/// @nodoc
mixin _$GetPostsInput {
  @JsonKey(name: '_id', includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get user => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  bool? get published => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeIfNull: false)
  GetPostCreatedAtInput? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get skip => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get limit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPostsInputCopyWith<GetPostsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostsInputCopyWith<$Res> {
  factory $GetPostsInputCopyWith(
          GetPostsInput value, $Res Function(GetPostsInput) then) =
      _$GetPostsInputCopyWithImpl<$Res, GetPostsInput>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id', includeIfNull: false)
          String? id,
      @JsonKey(includeIfNull: false)
          String? user,
      @JsonKey(includeIfNull: false)
          bool? published,
      @JsonKey(name: 'created_at', includeIfNull: false)
          GetPostCreatedAtInput? createdAt,
      @JsonKey(includeIfNull: false)
          int? skip,
      @JsonKey(includeIfNull: false)
          int? limit});

  $GetPostCreatedAtInputCopyWith<$Res>? get createdAt;
}

/// @nodoc
class _$GetPostsInputCopyWithImpl<$Res, $Val extends GetPostsInput>
    implements $GetPostsInputCopyWith<$Res> {
  _$GetPostsInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? published = freezed,
    Object? createdAt = freezed,
    Object? skip = freezed,
    Object? limit = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      published: freezed == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as GetPostCreatedAtInput?,
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GetPostCreatedAtInputCopyWith<$Res>? get createdAt {
    if (_value.createdAt == null) {
      return null;
    }

    return $GetPostCreatedAtInputCopyWith<$Res>(_value.createdAt!, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GetPostsInputCopyWith<$Res>
    implements $GetPostsInputCopyWith<$Res> {
  factory _$$_GetPostsInputCopyWith(
          _$_GetPostsInput value, $Res Function(_$_GetPostsInput) then) =
      __$$_GetPostsInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id', includeIfNull: false)
          String? id,
      @JsonKey(includeIfNull: false)
          String? user,
      @JsonKey(includeIfNull: false)
          bool? published,
      @JsonKey(name: 'created_at', includeIfNull: false)
          GetPostCreatedAtInput? createdAt,
      @JsonKey(includeIfNull: false)
          int? skip,
      @JsonKey(includeIfNull: false)
          int? limit});

  @override
  $GetPostCreatedAtInputCopyWith<$Res>? get createdAt;
}

/// @nodoc
class __$$_GetPostsInputCopyWithImpl<$Res>
    extends _$GetPostsInputCopyWithImpl<$Res, _$_GetPostsInput>
    implements _$$_GetPostsInputCopyWith<$Res> {
  __$$_GetPostsInputCopyWithImpl(
      _$_GetPostsInput _value, $Res Function(_$_GetPostsInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? published = freezed,
    Object? createdAt = freezed,
    Object? skip = freezed,
    Object? limit = freezed,
  }) {
    return _then(_$_GetPostsInput(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      published: freezed == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as GetPostCreatedAtInput?,
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_GetPostsInput implements _GetPostsInput {
  const _$_GetPostsInput(
      {@JsonKey(name: '_id', includeIfNull: false) this.id,
      @JsonKey(includeIfNull: false) this.user,
      @JsonKey(includeIfNull: false) this.published,
      @JsonKey(name: 'created_at', includeIfNull: false) this.createdAt,
      @JsonKey(includeIfNull: false) this.skip,
      @JsonKey(includeIfNull: false) this.limit});

  factory _$_GetPostsInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetPostsInputFromJson(json);

  @override
  @JsonKey(name: '_id', includeIfNull: false)
  final String? id;
  @override
  @JsonKey(includeIfNull: false)
  final String? user;
  @override
  @JsonKey(includeIfNull: false)
  final bool? published;
  @override
  @JsonKey(name: 'created_at', includeIfNull: false)
  final GetPostCreatedAtInput? createdAt;
  @override
  @JsonKey(includeIfNull: false)
  final int? skip;
  @override
  @JsonKey(includeIfNull: false)
  final int? limit;

  @override
  String toString() {
    return 'GetPostsInput(id: $id, user: $user, published: $published, createdAt: $createdAt, skip: $skip, limit: $limit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetPostsInput &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.published, published) ||
                other.published == published) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, user, published, createdAt, skip, limit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetPostsInputCopyWith<_$_GetPostsInput> get copyWith =>
      __$$_GetPostsInputCopyWithImpl<_$_GetPostsInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetPostsInputToJson(
      this,
    );
  }
}

abstract class _GetPostsInput implements GetPostsInput {
  const factory _GetPostsInput(
      {@JsonKey(name: '_id', includeIfNull: false)
          final String? id,
      @JsonKey(includeIfNull: false)
          final String? user,
      @JsonKey(includeIfNull: false)
          final bool? published,
      @JsonKey(name: 'created_at', includeIfNull: false)
          final GetPostCreatedAtInput? createdAt,
      @JsonKey(includeIfNull: false)
          final int? skip,
      @JsonKey(includeIfNull: false)
          final int? limit}) = _$_GetPostsInput;

  factory _GetPostsInput.fromJson(Map<String, dynamic> json) =
      _$_GetPostsInput.fromJson;

  @override
  @JsonKey(name: '_id', includeIfNull: false)
  String? get id;
  @override
  @JsonKey(includeIfNull: false)
  String? get user;
  @override
  @JsonKey(includeIfNull: false)
  bool? get published;
  @override
  @JsonKey(name: 'created_at', includeIfNull: false)
  GetPostCreatedAtInput? get createdAt;
  @override
  @JsonKey(includeIfNull: false)
  int? get skip;
  @override
  @JsonKey(includeIfNull: false)
  int? get limit;
  @override
  @JsonKey(ignore: true)
  _$$_GetPostsInputCopyWith<_$_GetPostsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

GetPostCreatedAtInput _$GetPostCreatedAtInputFromJson(
    Map<String, dynamic> json) {
  return _GetPostCreatedAtInput.fromJson(json);
}

/// @nodoc
mixin _$GetPostCreatedAtInput {
  @JsonKey(includeIfNull: false)
  DateTime? get gte => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  DateTime? get lte => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPostCreatedAtInputCopyWith<GetPostCreatedAtInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostCreatedAtInputCopyWith<$Res> {
  factory $GetPostCreatedAtInputCopyWith(GetPostCreatedAtInput value,
          $Res Function(GetPostCreatedAtInput) then) =
      _$GetPostCreatedAtInputCopyWithImpl<$Res, GetPostCreatedAtInput>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) DateTime? gte,
      @JsonKey(includeIfNull: false) DateTime? lte});
}

/// @nodoc
class _$GetPostCreatedAtInputCopyWithImpl<$Res,
        $Val extends GetPostCreatedAtInput>
    implements $GetPostCreatedAtInputCopyWith<$Res> {
  _$GetPostCreatedAtInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gte = freezed,
    Object? lte = freezed,
  }) {
    return _then(_value.copyWith(
      gte: freezed == gte
          ? _value.gte
          : gte // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lte: freezed == lte
          ? _value.lte
          : lte // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetPostCreatedAtInputCopyWith<$Res>
    implements $GetPostCreatedAtInputCopyWith<$Res> {
  factory _$$_GetPostCreatedAtInputCopyWith(_$_GetPostCreatedAtInput value,
          $Res Function(_$_GetPostCreatedAtInput) then) =
      __$$_GetPostCreatedAtInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) DateTime? gte,
      @JsonKey(includeIfNull: false) DateTime? lte});
}

/// @nodoc
class __$$_GetPostCreatedAtInputCopyWithImpl<$Res>
    extends _$GetPostCreatedAtInputCopyWithImpl<$Res, _$_GetPostCreatedAtInput>
    implements _$$_GetPostCreatedAtInputCopyWith<$Res> {
  __$$_GetPostCreatedAtInputCopyWithImpl(_$_GetPostCreatedAtInput _value,
      $Res Function(_$_GetPostCreatedAtInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gte = freezed,
    Object? lte = freezed,
  }) {
    return _then(_$_GetPostCreatedAtInput(
      gte: freezed == gte
          ? _value.gte
          : gte // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lte: freezed == lte
          ? _value.lte
          : lte // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetPostCreatedAtInput implements _GetPostCreatedAtInput {
  const _$_GetPostCreatedAtInput(
      {@JsonKey(includeIfNull: false) this.gte,
      @JsonKey(includeIfNull: false) this.lte});

  factory _$_GetPostCreatedAtInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetPostCreatedAtInputFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final DateTime? gte;
  @override
  @JsonKey(includeIfNull: false)
  final DateTime? lte;

  @override
  String toString() {
    return 'GetPostCreatedAtInput(gte: $gte, lte: $lte)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetPostCreatedAtInput &&
            (identical(other.gte, gte) || other.gte == gte) &&
            (identical(other.lte, lte) || other.lte == lte));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gte, lte);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetPostCreatedAtInputCopyWith<_$_GetPostCreatedAtInput> get copyWith =>
      __$$_GetPostCreatedAtInputCopyWithImpl<_$_GetPostCreatedAtInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetPostCreatedAtInputToJson(
      this,
    );
  }
}

abstract class _GetPostCreatedAtInput implements GetPostCreatedAtInput {
  const factory _GetPostCreatedAtInput(
          {@JsonKey(includeIfNull: false) final DateTime? gte,
          @JsonKey(includeIfNull: false) final DateTime? lte}) =
      _$_GetPostCreatedAtInput;

  factory _GetPostCreatedAtInput.fromJson(Map<String, dynamic> json) =
      _$_GetPostCreatedAtInput.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  DateTime? get gte;
  @override
  @JsonKey(includeIfNull: false)
  DateTime? get lte;
  @override
  @JsonKey(ignore: true)
  _$$_GetPostCreatedAtInputCopyWith<_$_GetPostCreatedAtInput> get copyWith =>
      throw _privateConstructorUsedError;
}
