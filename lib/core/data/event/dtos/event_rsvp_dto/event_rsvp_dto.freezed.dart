// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_rsvp_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventRsvpDto _$EventRsvpDtoFromJson(Map<String, dynamic> json) {
  return _EventRSVPDto.fromJson(json);
}

/// @nodoc
mixin _$EventRsvpDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  EventRsvpMessagesDto? get messages => throw _privateConstructorUsedError;
  EventRsvpPaymentDto? get payment => throw _privateConstructorUsedError;
  EventRsvpState? get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventRsvpDtoCopyWith<EventRsvpDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRsvpDtoCopyWith<$Res> {
  factory $EventRsvpDtoCopyWith(
          EventRsvpDto value, $Res Function(EventRsvpDto) then) =
      _$EventRsvpDtoCopyWithImpl<$Res, EventRsvpDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      EventRsvpMessagesDto? messages,
      EventRsvpPaymentDto? payment,
      EventRsvpState? state});

  $EventRsvpMessagesDtoCopyWith<$Res>? get messages;
  $EventRsvpPaymentDtoCopyWith<$Res>? get payment;
}

/// @nodoc
class _$EventRsvpDtoCopyWithImpl<$Res, $Val extends EventRsvpDto>
    implements $EventRsvpDtoCopyWith<$Res> {
  _$EventRsvpDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? messages = freezed,
    Object? payment = freezed,
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as EventRsvpMessagesDto?,
      payment: freezed == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as EventRsvpPaymentDto?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as EventRsvpState?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventRsvpMessagesDtoCopyWith<$Res>? get messages {
    if (_value.messages == null) {
      return null;
    }

    return $EventRsvpMessagesDtoCopyWith<$Res>(_value.messages!, (value) {
      return _then(_value.copyWith(messages: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EventRsvpPaymentDtoCopyWith<$Res>? get payment {
    if (_value.payment == null) {
      return null;
    }

    return $EventRsvpPaymentDtoCopyWith<$Res>(_value.payment!, (value) {
      return _then(_value.copyWith(payment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventRSVPDtoCopyWith<$Res>
    implements $EventRsvpDtoCopyWith<$Res> {
  factory _$$_EventRSVPDtoCopyWith(
          _$_EventRSVPDto value, $Res Function(_$_EventRSVPDto) then) =
      __$$_EventRSVPDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      EventRsvpMessagesDto? messages,
      EventRsvpPaymentDto? payment,
      EventRsvpState? state});

  @override
  $EventRsvpMessagesDtoCopyWith<$Res>? get messages;
  @override
  $EventRsvpPaymentDtoCopyWith<$Res>? get payment;
}

/// @nodoc
class __$$_EventRSVPDtoCopyWithImpl<$Res>
    extends _$EventRsvpDtoCopyWithImpl<$Res, _$_EventRSVPDto>
    implements _$$_EventRSVPDtoCopyWith<$Res> {
  __$$_EventRSVPDtoCopyWithImpl(
      _$_EventRSVPDto _value, $Res Function(_$_EventRSVPDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? messages = freezed,
    Object? payment = freezed,
    Object? state = freezed,
  }) {
    return _then(_$_EventRSVPDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as EventRsvpMessagesDto?,
      payment: freezed == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as EventRsvpPaymentDto?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as EventRsvpState?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_EventRSVPDto implements _EventRSVPDto {
  const _$_EventRSVPDto(
      {@JsonKey(name: '_id') this.id, this.messages, this.payment, this.state});

  factory _$_EventRSVPDto.fromJson(Map<String, dynamic> json) =>
      _$$_EventRSVPDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final EventRsvpMessagesDto? messages;
  @override
  final EventRsvpPaymentDto? payment;
  @override
  final EventRsvpState? state;

  @override
  String toString() {
    return 'EventRsvpDto(id: $id, messages: $messages, payment: $payment, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventRSVPDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.messages, messages) ||
                other.messages == messages) &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, messages, payment, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventRSVPDtoCopyWith<_$_EventRSVPDto> get copyWith =>
      __$$_EventRSVPDtoCopyWithImpl<_$_EventRSVPDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventRSVPDtoToJson(
      this,
    );
  }
}

abstract class _EventRSVPDto implements EventRsvpDto {
  const factory _EventRSVPDto(
      {@JsonKey(name: '_id') final String? id,
      final EventRsvpMessagesDto? messages,
      final EventRsvpPaymentDto? payment,
      final EventRsvpState? state}) = _$_EventRSVPDto;

  factory _EventRSVPDto.fromJson(Map<String, dynamic> json) =
      _$_EventRSVPDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  EventRsvpMessagesDto? get messages;
  @override
  EventRsvpPaymentDto? get payment;
  @override
  EventRsvpState? get state;
  @override
  @JsonKey(ignore: true)
  _$$_EventRSVPDtoCopyWith<_$_EventRSVPDto> get copyWith =>
      throw _privateConstructorUsedError;
}

EventRsvpMessagesDto _$EventRsvpMessagesDtoFromJson(Map<String, dynamic> json) {
  return _EventRsvpMessagesDto.fromJson(json);
}

/// @nodoc
mixin _$EventRsvpMessagesDto {
  String? get primary => throw _privateConstructorUsedError;
  String? get secondary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventRsvpMessagesDtoCopyWith<EventRsvpMessagesDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRsvpMessagesDtoCopyWith<$Res> {
  factory $EventRsvpMessagesDtoCopyWith(EventRsvpMessagesDto value,
          $Res Function(EventRsvpMessagesDto) then) =
      _$EventRsvpMessagesDtoCopyWithImpl<$Res, EventRsvpMessagesDto>;
  @useResult
  $Res call({String? primary, String? secondary});
}

/// @nodoc
class _$EventRsvpMessagesDtoCopyWithImpl<$Res,
        $Val extends EventRsvpMessagesDto>
    implements $EventRsvpMessagesDtoCopyWith<$Res> {
  _$EventRsvpMessagesDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? secondary = freezed,
  }) {
    return _then(_value.copyWith(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String?,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventRsvpMessagesDtoCopyWith<$Res>
    implements $EventRsvpMessagesDtoCopyWith<$Res> {
  factory _$$_EventRsvpMessagesDtoCopyWith(_$_EventRsvpMessagesDto value,
          $Res Function(_$_EventRsvpMessagesDto) then) =
      __$$_EventRsvpMessagesDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? primary, String? secondary});
}

/// @nodoc
class __$$_EventRsvpMessagesDtoCopyWithImpl<$Res>
    extends _$EventRsvpMessagesDtoCopyWithImpl<$Res, _$_EventRsvpMessagesDto>
    implements _$$_EventRsvpMessagesDtoCopyWith<$Res> {
  __$$_EventRsvpMessagesDtoCopyWithImpl(_$_EventRsvpMessagesDto _value,
      $Res Function(_$_EventRsvpMessagesDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? secondary = freezed,
  }) {
    return _then(_$_EventRsvpMessagesDto(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String?,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventRsvpMessagesDto implements _EventRsvpMessagesDto {
  _$_EventRsvpMessagesDto({this.primary, this.secondary});

  factory _$_EventRsvpMessagesDto.fromJson(Map<String, dynamic> json) =>
      _$$_EventRsvpMessagesDtoFromJson(json);

  @override
  final String? primary;
  @override
  final String? secondary;

  @override
  String toString() {
    return 'EventRsvpMessagesDto(primary: $primary, secondary: $secondary)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventRsvpMessagesDto &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, primary, secondary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventRsvpMessagesDtoCopyWith<_$_EventRsvpMessagesDto> get copyWith =>
      __$$_EventRsvpMessagesDtoCopyWithImpl<_$_EventRsvpMessagesDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventRsvpMessagesDtoToJson(
      this,
    );
  }
}

abstract class _EventRsvpMessagesDto implements EventRsvpMessagesDto {
  factory _EventRsvpMessagesDto(
      {final String? primary,
      final String? secondary}) = _$_EventRsvpMessagesDto;

  factory _EventRsvpMessagesDto.fromJson(Map<String, dynamic> json) =
      _$_EventRsvpMessagesDto.fromJson;

  @override
  String? get primary;
  @override
  String? get secondary;
  @override
  @JsonKey(ignore: true)
  _$$_EventRsvpMessagesDtoCopyWith<_$_EventRsvpMessagesDto> get copyWith =>
      throw _privateConstructorUsedError;
}

EventRsvpPaymentDto _$EventRsvpPaymentDtoFromJson(Map<String, dynamic> json) {
  return _EventRsvpPaymentDto.fromJson(json);
}

/// @nodoc
mixin _$EventRsvpPaymentDto {
  double? get amount => throw _privateConstructorUsedError;
  Currency? get currency => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventRsvpPaymentDtoCopyWith<EventRsvpPaymentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRsvpPaymentDtoCopyWith<$Res> {
  factory $EventRsvpPaymentDtoCopyWith(
          EventRsvpPaymentDto value, $Res Function(EventRsvpPaymentDto) then) =
      _$EventRsvpPaymentDtoCopyWithImpl<$Res, EventRsvpPaymentDto>;
  @useResult
  $Res call({double? amount, Currency? currency, String? provider});
}

/// @nodoc
class _$EventRsvpPaymentDtoCopyWithImpl<$Res, $Val extends EventRsvpPaymentDto>
    implements $EventRsvpPaymentDtoCopyWith<$Res> {
  _$EventRsvpPaymentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? currency = freezed,
    Object? provider = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventRsvpPaymentDtoCopyWith<$Res>
    implements $EventRsvpPaymentDtoCopyWith<$Res> {
  factory _$$_EventRsvpPaymentDtoCopyWith(_$_EventRsvpPaymentDto value,
          $Res Function(_$_EventRsvpPaymentDto) then) =
      __$$_EventRsvpPaymentDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? amount, Currency? currency, String? provider});
}

/// @nodoc
class __$$_EventRsvpPaymentDtoCopyWithImpl<$Res>
    extends _$EventRsvpPaymentDtoCopyWithImpl<$Res, _$_EventRsvpPaymentDto>
    implements _$$_EventRsvpPaymentDtoCopyWith<$Res> {
  __$$_EventRsvpPaymentDtoCopyWithImpl(_$_EventRsvpPaymentDto _value,
      $Res Function(_$_EventRsvpPaymentDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? currency = freezed,
    Object? provider = freezed,
  }) {
    return _then(_$_EventRsvpPaymentDto(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventRsvpPaymentDto implements _EventRsvpPaymentDto {
  _$_EventRsvpPaymentDto({this.amount, this.currency, this.provider});

  factory _$_EventRsvpPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$$_EventRsvpPaymentDtoFromJson(json);

  @override
  final double? amount;
  @override
  final Currency? currency;
  @override
  final String? provider;

  @override
  String toString() {
    return 'EventRsvpPaymentDto(amount: $amount, currency: $currency, provider: $provider)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventRsvpPaymentDto &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, currency, provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventRsvpPaymentDtoCopyWith<_$_EventRsvpPaymentDto> get copyWith =>
      __$$_EventRsvpPaymentDtoCopyWithImpl<_$_EventRsvpPaymentDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventRsvpPaymentDtoToJson(
      this,
    );
  }
}

abstract class _EventRsvpPaymentDto implements EventRsvpPaymentDto {
  factory _EventRsvpPaymentDto(
      {final double? amount,
      final Currency? currency,
      final String? provider}) = _$_EventRsvpPaymentDto;

  factory _EventRsvpPaymentDto.fromJson(Map<String, dynamic> json) =
      _$_EventRsvpPaymentDto.fromJson;

  @override
  double? get amount;
  @override
  Currency? get currency;
  @override
  String? get provider;
  @override
  @JsonKey(ignore: true)
  _$$_EventRsvpPaymentDtoCopyWith<_$_EventRsvpPaymentDto> get copyWith =>
      throw _privateConstructorUsedError;
}
