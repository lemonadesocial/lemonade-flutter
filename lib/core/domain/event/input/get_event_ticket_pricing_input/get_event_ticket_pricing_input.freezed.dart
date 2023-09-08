// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_event_ticket_pricing_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetEventTicketPricingInput _$GetEventTicketPricingInputFromJson(
    Map<String, dynamic> json) {
  return _GetEventTicketPricingInput.fromJson(json);
}

/// @nodoc
mixin _$GetEventTicketPricingInput {
  String get event => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get discount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetEventTicketPricingInputCopyWith<GetEventTicketPricingInput>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetEventTicketPricingInputCopyWith<$Res> {
  factory $GetEventTicketPricingInputCopyWith(GetEventTicketPricingInput value,
          $Res Function(GetEventTicketPricingInput) then) =
      _$GetEventTicketPricingInputCopyWithImpl<$Res,
          GetEventTicketPricingInput>;
  @useResult
  $Res call({String event, String? type, String? discount});
}

/// @nodoc
class _$GetEventTicketPricingInputCopyWithImpl<$Res,
        $Val extends GetEventTicketPricingInput>
    implements $GetEventTicketPricingInputCopyWith<$Res> {
  _$GetEventTicketPricingInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? type = freezed,
    Object? discount = freezed,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetEventTicketPricingInputCopyWith<$Res>
    implements $GetEventTicketPricingInputCopyWith<$Res> {
  factory _$$_GetEventTicketPricingInputCopyWith(
          _$_GetEventTicketPricingInput value,
          $Res Function(_$_GetEventTicketPricingInput) then) =
      __$$_GetEventTicketPricingInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String event, String? type, String? discount});
}

/// @nodoc
class __$$_GetEventTicketPricingInputCopyWithImpl<$Res>
    extends _$GetEventTicketPricingInputCopyWithImpl<$Res,
        _$_GetEventTicketPricingInput>
    implements _$$_GetEventTicketPricingInputCopyWith<$Res> {
  __$$_GetEventTicketPricingInputCopyWithImpl(
      _$_GetEventTicketPricingInput _value,
      $Res Function(_$_GetEventTicketPricingInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? type = freezed,
    Object? discount = freezed,
  }) {
    return _then(_$_GetEventTicketPricingInput(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_GetEventTicketPricingInput implements _GetEventTicketPricingInput {
  _$_GetEventTicketPricingInput(
      {required this.event, this.type, this.discount});

  factory _$_GetEventTicketPricingInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetEventTicketPricingInputFromJson(json);

  @override
  final String event;
  @override
  final String? type;
  @override
  final String? discount;

  @override
  String toString() {
    return 'GetEventTicketPricingInput(event: $event, type: $type, discount: $discount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetEventTicketPricingInput &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, event, type, discount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetEventTicketPricingInputCopyWith<_$_GetEventTicketPricingInput>
      get copyWith => __$$_GetEventTicketPricingInputCopyWithImpl<
          _$_GetEventTicketPricingInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetEventTicketPricingInputToJson(
      this,
    );
  }
}

abstract class _GetEventTicketPricingInput
    implements GetEventTicketPricingInput {
  factory _GetEventTicketPricingInput(
      {required final String event,
      final String? type,
      final String? discount}) = _$_GetEventTicketPricingInput;

  factory _GetEventTicketPricingInput.fromJson(Map<String, dynamic> json) =
      _$_GetEventTicketPricingInput.fromJson;

  @override
  String get event;
  @override
  String? get type;
  @override
  String? get discount;
  @override
  @JsonKey(ignore: true)
  _$$_GetEventTicketPricingInputCopyWith<_$_GetEventTicketPricingInput>
      get copyWith => throw _privateConstructorUsedError;
}
