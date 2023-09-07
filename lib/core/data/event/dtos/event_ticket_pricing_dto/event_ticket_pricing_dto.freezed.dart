// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_ticket_pricing_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventTicketPricingDto _$EventTicketPricingDtoFromJson(
    Map<String, dynamic> json) {
  return _EventTicketPricingDto.fromJson(json);
}

/// @nodoc
mixin _$EventTicketPricingDto {
  @JsonKey(name: '_id')
  dynamic get id => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  Currency? get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventTicketPricingDtoCopyWith<EventTicketPricingDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventTicketPricingDtoCopyWith<$Res> {
  factory $EventTicketPricingDtoCopyWith(EventTicketPricingDto value,
          $Res Function(EventTicketPricingDto) then) =
      _$EventTicketPricingDtoCopyWithImpl<$Res, EventTicketPricingDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') dynamic id, double? amount, Currency? currency});
}

/// @nodoc
class _$EventTicketPricingDtoCopyWithImpl<$Res,
        $Val extends EventTicketPricingDto>
    implements $EventTicketPricingDtoCopyWith<$Res> {
  _$EventTicketPricingDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventTicketPricingDtoCopyWith<$Res>
    implements $EventTicketPricingDtoCopyWith<$Res> {
  factory _$$_EventTicketPricingDtoCopyWith(_$_EventTicketPricingDto value,
          $Res Function(_$_EventTicketPricingDto) then) =
      __$$_EventTicketPricingDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') dynamic id, double? amount, Currency? currency});
}

/// @nodoc
class __$$_EventTicketPricingDtoCopyWithImpl<$Res>
    extends _$EventTicketPricingDtoCopyWithImpl<$Res, _$_EventTicketPricingDto>
    implements _$$_EventTicketPricingDtoCopyWith<$Res> {
  __$$_EventTicketPricingDtoCopyWithImpl(_$_EventTicketPricingDto _value,
      $Res Function(_$_EventTicketPricingDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$_EventTicketPricingDto(
      id: freezed == id ? _value.id! : id,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventTicketPricingDto implements _EventTicketPricingDto {
  _$_EventTicketPricingDto(
      {@JsonKey(name: '_id') this.id, this.amount, this.currency});

  factory _$_EventTicketPricingDto.fromJson(Map<String, dynamic> json) =>
      _$$_EventTicketPricingDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final dynamic id;
  @override
  final double? amount;
  @override
  final Currency? currency;

  @override
  String toString() {
    return 'EventTicketPricingDto(id: $id, amount: $amount, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventTicketPricingDto &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(id), amount, currency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventTicketPricingDtoCopyWith<_$_EventTicketPricingDto> get copyWith =>
      __$$_EventTicketPricingDtoCopyWithImpl<_$_EventTicketPricingDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventTicketPricingDtoToJson(
      this,
    );
  }
}

abstract class _EventTicketPricingDto implements EventTicketPricingDto {
  factory _EventTicketPricingDto(
      {@JsonKey(name: '_id') final dynamic id,
      final double? amount,
      final Currency? currency}) = _$_EventTicketPricingDto;

  factory _EventTicketPricingDto.fromJson(Map<String, dynamic> json) =
      _$_EventTicketPricingDto.fromJson;

  @override
  @JsonKey(name: '_id')
  dynamic get id;
  @override
  double? get amount;
  @override
  Currency? get currency;
  @override
  @JsonKey(ignore: true)
  _$$_EventTicketPricingDtoCopyWith<_$_EventTicketPricingDto> get copyWith =>
      throw _privateConstructorUsedError;
}
