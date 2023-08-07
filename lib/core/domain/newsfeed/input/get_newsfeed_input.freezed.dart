// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_newsfeed_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetNewsfeedInput _$GetNewsfeedInputFromJson(Map<String, dynamic> json) {
  return _GetNewsfeedInput.fromJson(json);
}

/// @nodoc
mixin _$GetNewsfeedInput {
  @JsonKey(includeIfNull: false)
  int? get offset => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetNewsfeedInputCopyWith<GetNewsfeedInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetNewsfeedInputCopyWith<$Res> {
  factory $GetNewsfeedInputCopyWith(
          GetNewsfeedInput value, $Res Function(GetNewsfeedInput) then) =
      _$GetNewsfeedInputCopyWithImpl<$Res, GetNewsfeedInput>;
  @useResult
  $Res call({@JsonKey(includeIfNull: false) int? offset});
}

/// @nodoc
class _$GetNewsfeedInputCopyWithImpl<$Res, $Val extends GetNewsfeedInput>
    implements $GetNewsfeedInputCopyWith<$Res> {
  _$GetNewsfeedInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
  }) {
    return _then(_value.copyWith(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetNewsfeedInputCopyWith<$Res>
    implements $GetNewsfeedInputCopyWith<$Res> {
  factory _$$_GetNewsfeedInputCopyWith(
          _$_GetNewsfeedInput value, $Res Function(_$_GetNewsfeedInput) then) =
      __$$_GetNewsfeedInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(includeIfNull: false) int? offset});
}

/// @nodoc
class __$$_GetNewsfeedInputCopyWithImpl<$Res>
    extends _$GetNewsfeedInputCopyWithImpl<$Res, _$_GetNewsfeedInput>
    implements _$$_GetNewsfeedInputCopyWith<$Res> {
  __$$_GetNewsfeedInputCopyWithImpl(
      _$_GetNewsfeedInput _value, $Res Function(_$_GetNewsfeedInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
  }) {
    return _then(_$_GetNewsfeedInput(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_GetNewsfeedInput implements _GetNewsfeedInput {
  const _$_GetNewsfeedInput({@JsonKey(includeIfNull: false) this.offset});

  factory _$_GetNewsfeedInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetNewsfeedInputFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final int? offset;

  @override
  String toString() {
    return 'GetNewsfeedInput(offset: $offset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetNewsfeedInput &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, offset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetNewsfeedInputCopyWith<_$_GetNewsfeedInput> get copyWith =>
      __$$_GetNewsfeedInputCopyWithImpl<_$_GetNewsfeedInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetNewsfeedInputToJson(
      this,
    );
  }
}

abstract class _GetNewsfeedInput implements GetNewsfeedInput {
  const factory _GetNewsfeedInput(
      {@JsonKey(includeIfNull: false) final int? offset}) = _$_GetNewsfeedInput;

  factory _GetNewsfeedInput.fromJson(Map<String, dynamic> json) =
      _$_GetNewsfeedInput.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  int? get offset;
  @override
  @JsonKey(ignore: true)
  _$$_GetNewsfeedInputCopyWith<_$_GetNewsfeedInput> get copyWith =>
      throw _privateConstructorUsedError;
}

GetNewsfeedCreatedAtInput _$GetNewsfeedCreatedAtInputFromJson(
    Map<String, dynamic> json) {
  return _GetNewsfeedCreatedAtInput.fromJson(json);
}

/// @nodoc
mixin _$GetNewsfeedCreatedAtInput {
  @JsonKey(includeIfNull: false)
  DateTime? get gte => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  DateTime? get lte => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetNewsfeedCreatedAtInputCopyWith<GetNewsfeedCreatedAtInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetNewsfeedCreatedAtInputCopyWith<$Res> {
  factory $GetNewsfeedCreatedAtInputCopyWith(GetNewsfeedCreatedAtInput value,
          $Res Function(GetNewsfeedCreatedAtInput) then) =
      _$GetNewsfeedCreatedAtInputCopyWithImpl<$Res, GetNewsfeedCreatedAtInput>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) DateTime? gte,
      @JsonKey(includeIfNull: false) DateTime? lte});
}

/// @nodoc
class _$GetNewsfeedCreatedAtInputCopyWithImpl<$Res,
        $Val extends GetNewsfeedCreatedAtInput>
    implements $GetNewsfeedCreatedAtInputCopyWith<$Res> {
  _$GetNewsfeedCreatedAtInputCopyWithImpl(this._value, this._then);

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
abstract class _$$_GetNewsfeedCreatedAtInputCopyWith<$Res>
    implements $GetNewsfeedCreatedAtInputCopyWith<$Res> {
  factory _$$_GetNewsfeedCreatedAtInputCopyWith(
          _$_GetNewsfeedCreatedAtInput value,
          $Res Function(_$_GetNewsfeedCreatedAtInput) then) =
      __$$_GetNewsfeedCreatedAtInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) DateTime? gte,
      @JsonKey(includeIfNull: false) DateTime? lte});
}

/// @nodoc
class __$$_GetNewsfeedCreatedAtInputCopyWithImpl<$Res>
    extends _$GetNewsfeedCreatedAtInputCopyWithImpl<$Res,
        _$_GetNewsfeedCreatedAtInput>
    implements _$$_GetNewsfeedCreatedAtInputCopyWith<$Res> {
  __$$_GetNewsfeedCreatedAtInputCopyWithImpl(
      _$_GetNewsfeedCreatedAtInput _value,
      $Res Function(_$_GetNewsfeedCreatedAtInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gte = freezed,
    Object? lte = freezed,
  }) {
    return _then(_$_GetNewsfeedCreatedAtInput(
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
class _$_GetNewsfeedCreatedAtInput implements _GetNewsfeedCreatedAtInput {
  const _$_GetNewsfeedCreatedAtInput(
      {@JsonKey(includeIfNull: false) this.gte,
      @JsonKey(includeIfNull: false) this.lte});

  factory _$_GetNewsfeedCreatedAtInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetNewsfeedCreatedAtInputFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final DateTime? gte;
  @override
  @JsonKey(includeIfNull: false)
  final DateTime? lte;

  @override
  String toString() {
    return 'GetNewsfeedCreatedAtInput(gte: $gte, lte: $lte)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetNewsfeedCreatedAtInput &&
            (identical(other.gte, gte) || other.gte == gte) &&
            (identical(other.lte, lte) || other.lte == lte));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gte, lte);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetNewsfeedCreatedAtInputCopyWith<_$_GetNewsfeedCreatedAtInput>
      get copyWith => __$$_GetNewsfeedCreatedAtInputCopyWithImpl<
          _$_GetNewsfeedCreatedAtInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetNewsfeedCreatedAtInputToJson(
      this,
    );
  }
}

abstract class _GetNewsfeedCreatedAtInput implements GetNewsfeedCreatedAtInput {
  const factory _GetNewsfeedCreatedAtInput(
          {@JsonKey(includeIfNull: false) final DateTime? gte,
          @JsonKey(includeIfNull: false) final DateTime? lte}) =
      _$_GetNewsfeedCreatedAtInput;

  factory _GetNewsfeedCreatedAtInput.fromJson(Map<String, dynamic> json) =
      _$_GetNewsfeedCreatedAtInput.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  DateTime? get gte;
  @override
  @JsonKey(includeIfNull: false)
  DateTime? get lte;
  @override
  @JsonKey(ignore: true)
  _$$_GetNewsfeedCreatedAtInputCopyWith<_$_GetNewsfeedCreatedAtInput>
      get copyWith => throw _privateConstructorUsedError;
}
