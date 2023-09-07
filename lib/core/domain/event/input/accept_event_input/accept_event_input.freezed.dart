// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accept_event_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AcceptEventInput _$AcceptEventInputFromJson(Map<String, dynamic> json) {
  return _AcceptEventInput.fromJson(json);
}

/// @nodoc
mixin _$AcceptEventInput {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'skip_payment', defaultValue: true)
  bool? get skipPayment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AcceptEventInputCopyWith<AcceptEventInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptEventInputCopyWith<$Res> {
  factory $AcceptEventInputCopyWith(
          AcceptEventInput value, $Res Function(AcceptEventInput) then) =
      _$AcceptEventInputCopyWithImpl<$Res, AcceptEventInput>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'skip_payment', defaultValue: true) bool? skipPayment});
}

/// @nodoc
class _$AcceptEventInputCopyWithImpl<$Res, $Val extends AcceptEventInput>
    implements $AcceptEventInputCopyWith<$Res> {
  _$AcceptEventInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? skipPayment = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      skipPayment: freezed == skipPayment
          ? _value.skipPayment
          : skipPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AcceptEventInputCopyWith<$Res>
    implements $AcceptEventInputCopyWith<$Res> {
  factory _$$_AcceptEventInputCopyWith(
          _$_AcceptEventInput value, $Res Function(_$_AcceptEventInput) then) =
      __$$_AcceptEventInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'skip_payment', defaultValue: true) bool? skipPayment});
}

/// @nodoc
class __$$_AcceptEventInputCopyWithImpl<$Res>
    extends _$AcceptEventInputCopyWithImpl<$Res, _$_AcceptEventInput>
    implements _$$_AcceptEventInputCopyWith<$Res> {
  __$$_AcceptEventInputCopyWithImpl(
      _$_AcceptEventInput _value, $Res Function(_$_AcceptEventInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? skipPayment = freezed,
  }) {
    return _then(_$_AcceptEventInput(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      skipPayment: freezed == skipPayment
          ? _value.skipPayment
          : skipPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_AcceptEventInput implements _AcceptEventInput {
  _$_AcceptEventInput(
      {@JsonKey(name: '_id') required this.id,
      @JsonKey(name: 'skip_payment', defaultValue: true) this.skipPayment});

  factory _$_AcceptEventInput.fromJson(Map<String, dynamic> json) =>
      _$$_AcceptEventInputFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey(name: 'skip_payment', defaultValue: true)
  final bool? skipPayment;

  @override
  String toString() {
    return 'AcceptEventInput(id: $id, skipPayment: $skipPayment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AcceptEventInput &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.skipPayment, skipPayment) ||
                other.skipPayment == skipPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, skipPayment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AcceptEventInputCopyWith<_$_AcceptEventInput> get copyWith =>
      __$$_AcceptEventInputCopyWithImpl<_$_AcceptEventInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AcceptEventInputToJson(
      this,
    );
  }
}

abstract class _AcceptEventInput implements AcceptEventInput {
  factory _AcceptEventInput(
      {@JsonKey(name: '_id') required final String id,
      @JsonKey(name: 'skip_payment', defaultValue: true)
      final bool? skipPayment}) = _$_AcceptEventInput;

  factory _AcceptEventInput.fromJson(Map<String, dynamic> json) =
      _$_AcceptEventInput.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  @JsonKey(name: 'skip_payment', defaultValue: true)
  bool? get skipPayment;
  @override
  @JsonKey(ignore: true)
  _$$_AcceptEventInputCopyWith<_$_AcceptEventInput> get copyWith =>
      throw _privateConstructorUsedError;
}
