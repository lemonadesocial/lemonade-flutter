// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) {
  return _PaymentDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  Currency? get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentDtoCopyWith<PaymentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentDtoCopyWith<$Res> {
  factory $PaymentDtoCopyWith(
          PaymentDto value, $Res Function(PaymentDto) then) =
      _$PaymentDtoCopyWithImpl<$Res, PaymentDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id, double? amount, Currency? currency});
}

/// @nodoc
class _$PaymentDtoCopyWithImpl<$Res, $Val extends PaymentDto>
    implements $PaymentDtoCopyWith<$Res> {
  _$PaymentDtoCopyWithImpl(this._value, this._then);

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
              as String?,
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
abstract class _$$_PaymentDtoCopyWith<$Res>
    implements $PaymentDtoCopyWith<$Res> {
  factory _$$_PaymentDtoCopyWith(
          _$_PaymentDto value, $Res Function(_$_PaymentDto) then) =
      __$$_PaymentDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id, double? amount, Currency? currency});
}

/// @nodoc
class __$$_PaymentDtoCopyWithImpl<$Res>
    extends _$PaymentDtoCopyWithImpl<$Res, _$_PaymentDto>
    implements _$$_PaymentDtoCopyWith<$Res> {
  __$$_PaymentDtoCopyWithImpl(
      _$_PaymentDto _value, $Res Function(_$_PaymentDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$_PaymentDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_PaymentDto implements _PaymentDto {
  const _$_PaymentDto(
      {@JsonKey(name: '_id') this.id, this.amount, this.currency});

  factory _$_PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final double? amount;
  @override
  final Currency? currency;

  @override
  String toString() {
    return 'PaymentDto(id: $id, amount: $amount, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, currency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentDtoCopyWith<_$_PaymentDto> get copyWith =>
      __$$_PaymentDtoCopyWithImpl<_$_PaymentDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentDtoToJson(
      this,
    );
  }
}

abstract class _PaymentDto implements PaymentDto {
  const factory _PaymentDto(
      {@JsonKey(name: '_id') final String? id,
      final double? amount,
      final Currency? currency}) = _$_PaymentDto;

  factory _PaymentDto.fromJson(Map<String, dynamic> json) =
      _$_PaymentDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  double? get amount;
  @override
  Currency? get currency;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentDtoCopyWith<_$_PaymentDto> get copyWith =>
      throw _privateConstructorUsedError;
}
