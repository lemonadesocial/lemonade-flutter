// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_event_detail_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetEventDetailInput _$GetEventDetailInputFromJson(Map<String, dynamic> json) {
  return _GetEventDetailInput.fromJson(json);
}

/// @nodoc
mixin _$GetEventDetailInput {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetEventDetailInputCopyWith<GetEventDetailInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetEventDetailInputCopyWith<$Res> {
  factory $GetEventDetailInputCopyWith(
          GetEventDetailInput value, $Res Function(GetEventDetailInput) then) =
      _$GetEventDetailInputCopyWithImpl<$Res, GetEventDetailInput>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$GetEventDetailInputCopyWithImpl<$Res, $Val extends GetEventDetailInput>
    implements $GetEventDetailInputCopyWith<$Res> {
  _$GetEventDetailInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetEventDetailInputCopyWith<$Res>
    implements $GetEventDetailInputCopyWith<$Res> {
  factory _$$_GetEventDetailInputCopyWith(_$_GetEventDetailInput value,
          $Res Function(_$_GetEventDetailInput) then) =
      __$$_GetEventDetailInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$_GetEventDetailInputCopyWithImpl<$Res>
    extends _$GetEventDetailInputCopyWithImpl<$Res, _$_GetEventDetailInput>
    implements _$$_GetEventDetailInputCopyWith<$Res> {
  __$$_GetEventDetailInputCopyWithImpl(_$_GetEventDetailInput _value,
      $Res Function(_$_GetEventDetailInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$_GetEventDetailInput(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetEventDetailInput implements _GetEventDetailInput {
  const _$_GetEventDetailInput({required this.id});

  factory _$_GetEventDetailInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetEventDetailInputFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'GetEventDetailInput(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetEventDetailInput &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetEventDetailInputCopyWith<_$_GetEventDetailInput> get copyWith =>
      __$$_GetEventDetailInputCopyWithImpl<_$_GetEventDetailInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetEventDetailInputToJson(
      this,
    );
  }
}

abstract class _GetEventDetailInput implements GetEventDetailInput {
  const factory _GetEventDetailInput({required final String id}) =
      _$_GetEventDetailInput;

  factory _GetEventDetailInput.fromJson(Map<String, dynamic> json) =
      _$_GetEventDetailInput.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_GetEventDetailInputCopyWith<_$_GetEventDetailInput> get copyWith =>
      throw _privateConstructorUsedError;
}
