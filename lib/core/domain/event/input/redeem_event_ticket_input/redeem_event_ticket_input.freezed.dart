// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'redeem_event_ticket_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RedeemEventTicketInput _$RedeemEventTicketInputFromJson(
    Map<String, dynamic> json) {
  return _RedeemEventTicketInput.fromJson(json);
}

/// @nodoc
mixin _$RedeemEventTicketInput {
  String get event => throw _privateConstructorUsedError;
  double get count => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RedeemEventTicketInputCopyWith<RedeemEventTicketInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RedeemEventTicketInputCopyWith<$Res> {
  factory $RedeemEventTicketInputCopyWith(RedeemEventTicketInput value,
          $Res Function(RedeemEventTicketInput) then) =
      _$RedeemEventTicketInputCopyWithImpl<$Res, RedeemEventTicketInput>;
  @useResult
  $Res call({String event, double count, String? type, String? address});
}

/// @nodoc
class _$RedeemEventTicketInputCopyWithImpl<$Res,
        $Val extends RedeemEventTicketInput>
    implements $RedeemEventTicketInputCopyWith<$Res> {
  _$RedeemEventTicketInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? count = null,
    Object? type = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as double,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RedeemEventTicketInputCopyWith<$Res>
    implements $RedeemEventTicketInputCopyWith<$Res> {
  factory _$$_RedeemEventTicketInputCopyWith(_$_RedeemEventTicketInput value,
          $Res Function(_$_RedeemEventTicketInput) then) =
      __$$_RedeemEventTicketInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String event, double count, String? type, String? address});
}

/// @nodoc
class __$$_RedeemEventTicketInputCopyWithImpl<$Res>
    extends _$RedeemEventTicketInputCopyWithImpl<$Res,
        _$_RedeemEventTicketInput>
    implements _$$_RedeemEventTicketInputCopyWith<$Res> {
  __$$_RedeemEventTicketInputCopyWithImpl(_$_RedeemEventTicketInput _value,
      $Res Function(_$_RedeemEventTicketInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? count = null,
    Object? type = freezed,
    Object? address = freezed,
  }) {
    return _then(_$_RedeemEventTicketInput(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as double,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_RedeemEventTicketInput implements _RedeemEventTicketInput {
  _$_RedeemEventTicketInput(
      {required this.event, required this.count, this.type, this.address});

  factory _$_RedeemEventTicketInput.fromJson(Map<String, dynamic> json) =>
      _$$_RedeemEventTicketInputFromJson(json);

  @override
  final String event;
  @override
  final double count;
  @override
  final String? type;
  @override
  final String? address;

  @override
  String toString() {
    return 'RedeemEventTicketInput(event: $event, count: $count, type: $type, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RedeemEventTicketInput &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, event, count, type, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RedeemEventTicketInputCopyWith<_$_RedeemEventTicketInput> get copyWith =>
      __$$_RedeemEventTicketInputCopyWithImpl<_$_RedeemEventTicketInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RedeemEventTicketInputToJson(
      this,
    );
  }
}

abstract class _RedeemEventTicketInput implements RedeemEventTicketInput {
  factory _RedeemEventTicketInput(
      {required final String event,
      required final double count,
      final String? type,
      final String? address}) = _$_RedeemEventTicketInput;

  factory _RedeemEventTicketInput.fromJson(Map<String, dynamic> json) =
      _$_RedeemEventTicketInput.fromJson;

  @override
  String get event;
  @override
  double get count;
  @override
  String? get type;
  @override
  String? get address;
  @override
  @JsonKey(ignore: true)
  _$$_RedeemEventTicketInputCopyWith<_$_RedeemEventTicketInput> get copyWith =>
      throw _privateConstructorUsedError;
}
