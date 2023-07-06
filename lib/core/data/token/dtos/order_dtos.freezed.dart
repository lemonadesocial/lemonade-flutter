// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderComplexDto _$OrderComplexDtoFromJson(Map<String, dynamic> json) {
  return _OrderComplexDto.fromJson(json);
}

/// @nodoc
mixin _$OrderComplexDto {
  String get id => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  String get contract => throw _privateConstructorUsedError;
  OrderKind get kind => throw _privateConstructorUsedError;
  String get maker => throw _privateConstructorUsedError;
  String get network => throw _privateConstructorUsedError;
  bool get open => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  TokenSimpleDto get token => throw _privateConstructorUsedError;
  String? get typename => throw _privateConstructorUsedError;
  String? get bidAmount => throw _privateConstructorUsedError;
  String? get bidder => throw _privateConstructorUsedError;
  OrderCurrencyDto? get currency => throw _privateConstructorUsedError;
  UserDto? get makerExpanded => throw _privateConstructorUsedError;
  String? get openFrom => throw _privateConstructorUsedError;
  String? get openTo => throw _privateConstructorUsedError;
  String? get paidAmount => throw _privateConstructorUsedError;
  String? get taker => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderComplexDtoCopyWith<OrderComplexDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderComplexDtoCopyWith<$Res> {
  factory $OrderComplexDtoCopyWith(
          OrderComplexDto value, $Res Function(OrderComplexDto) then) =
      _$OrderComplexDtoCopyWithImpl<$Res, OrderComplexDto>;
  @useResult
  $Res call(
      {String id,
      String orderId,
      String contract,
      OrderKind kind,
      String maker,
      String network,
      bool open,
      String price,
      TokenSimpleDto token,
      String? typename,
      String? bidAmount,
      String? bidder,
      OrderCurrencyDto? currency,
      UserDto? makerExpanded,
      String? openFrom,
      String? openTo,
      String? paidAmount,
      String? taker,
      DateTime? createdAt,
      DateTime? updatedAt});

  $TokenSimpleDtoCopyWith<$Res> get token;
  $OrderCurrencyDtoCopyWith<$Res>? get currency;
  $UserDtoCopyWith<$Res>? get makerExpanded;
}

/// @nodoc
class _$OrderComplexDtoCopyWithImpl<$Res, $Val extends OrderComplexDto>
    implements $OrderComplexDtoCopyWith<$Res> {
  _$OrderComplexDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? contract = null,
    Object? kind = null,
    Object? maker = null,
    Object? network = null,
    Object? open = null,
    Object? price = null,
    Object? token = null,
    Object? typename = freezed,
    Object? bidAmount = freezed,
    Object? bidder = freezed,
    Object? currency = freezed,
    Object? makerExpanded = freezed,
    Object? openFrom = freezed,
    Object? openTo = freezed,
    Object? paidAmount = freezed,
    Object? taker = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      contract: null == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as OrderKind,
      maker: null == maker
          ? _value.maker
          : maker // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as bool,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenSimpleDto,
      typename: freezed == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String?,
      bidAmount: freezed == bidAmount
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      bidder: freezed == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as OrderCurrencyDto?,
      makerExpanded: freezed == makerExpanded
          ? _value.makerExpanded
          : makerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      openFrom: freezed == openFrom
          ? _value.openFrom
          : openFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      openTo: freezed == openTo
          ? _value.openTo
          : openTo // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      taker: freezed == taker
          ? _value.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenSimpleDtoCopyWith<$Res> get token {
    return $TokenSimpleDtoCopyWith<$Res>(_value.token, (value) {
      return _then(_value.copyWith(token: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderCurrencyDtoCopyWith<$Res>? get currency {
    if (_value.currency == null) {
      return null;
    }

    return $OrderCurrencyDtoCopyWith<$Res>(_value.currency!, (value) {
      return _then(_value.copyWith(currency: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get makerExpanded {
    if (_value.makerExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.makerExpanded!, (value) {
      return _then(_value.copyWith(makerExpanded: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OrderComplexDtoCopyWith<$Res>
    implements $OrderComplexDtoCopyWith<$Res> {
  factory _$$_OrderComplexDtoCopyWith(
          _$_OrderComplexDto value, $Res Function(_$_OrderComplexDto) then) =
      __$$_OrderComplexDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String orderId,
      String contract,
      OrderKind kind,
      String maker,
      String network,
      bool open,
      String price,
      TokenSimpleDto token,
      String? typename,
      String? bidAmount,
      String? bidder,
      OrderCurrencyDto? currency,
      UserDto? makerExpanded,
      String? openFrom,
      String? openTo,
      String? paidAmount,
      String? taker,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $TokenSimpleDtoCopyWith<$Res> get token;
  @override
  $OrderCurrencyDtoCopyWith<$Res>? get currency;
  @override
  $UserDtoCopyWith<$Res>? get makerExpanded;
}

/// @nodoc
class __$$_OrderComplexDtoCopyWithImpl<$Res>
    extends _$OrderComplexDtoCopyWithImpl<$Res, _$_OrderComplexDto>
    implements _$$_OrderComplexDtoCopyWith<$Res> {
  __$$_OrderComplexDtoCopyWithImpl(
      _$_OrderComplexDto _value, $Res Function(_$_OrderComplexDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? contract = null,
    Object? kind = null,
    Object? maker = null,
    Object? network = null,
    Object? open = null,
    Object? price = null,
    Object? token = null,
    Object? typename = freezed,
    Object? bidAmount = freezed,
    Object? bidder = freezed,
    Object? currency = freezed,
    Object? makerExpanded = freezed,
    Object? openFrom = freezed,
    Object? openTo = freezed,
    Object? paidAmount = freezed,
    Object? taker = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_OrderComplexDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      contract: null == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as OrderKind,
      maker: null == maker
          ? _value.maker
          : maker // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as bool,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenSimpleDto,
      typename: freezed == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String?,
      bidAmount: freezed == bidAmount
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      bidder: freezed == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as OrderCurrencyDto?,
      makerExpanded: freezed == makerExpanded
          ? _value.makerExpanded
          : makerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      openFrom: freezed == openFrom
          ? _value.openFrom
          : openFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      openTo: freezed == openTo
          ? _value.openTo
          : openTo // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      taker: freezed == taker
          ? _value.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderComplexDto implements _OrderComplexDto {
  const _$_OrderComplexDto(
      {required this.id,
      required this.orderId,
      required this.contract,
      required this.kind,
      required this.maker,
      required this.network,
      required this.open,
      required this.price,
      required this.token,
      this.typename,
      this.bidAmount,
      this.bidder,
      this.currency,
      this.makerExpanded,
      this.openFrom,
      this.openTo,
      this.paidAmount,
      this.taker,
      this.createdAt,
      this.updatedAt});

  factory _$_OrderComplexDto.fromJson(Map<String, dynamic> json) =>
      _$$_OrderComplexDtoFromJson(json);

  @override
  final String id;
  @override
  final String orderId;
  @override
  final String contract;
  @override
  final OrderKind kind;
  @override
  final String maker;
  @override
  final String network;
  @override
  final bool open;
  @override
  final String price;
  @override
  final TokenSimpleDto token;
  @override
  final String? typename;
  @override
  final String? bidAmount;
  @override
  final String? bidder;
  @override
  final OrderCurrencyDto? currency;
  @override
  final UserDto? makerExpanded;
  @override
  final String? openFrom;
  @override
  final String? openTo;
  @override
  final String? paidAmount;
  @override
  final String? taker;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'OrderComplexDto(id: $id, orderId: $orderId, contract: $contract, kind: $kind, maker: $maker, network: $network, open: $open, price: $price, token: $token, typename: $typename, bidAmount: $bidAmount, bidder: $bidder, currency: $currency, makerExpanded: $makerExpanded, openFrom: $openFrom, openTo: $openTo, paidAmount: $paidAmount, taker: $taker, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderComplexDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.contract, contract) ||
                other.contract == contract) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.maker, maker) || other.maker == maker) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.typename, typename) ||
                other.typename == typename) &&
            (identical(other.bidAmount, bidAmount) ||
                other.bidAmount == bidAmount) &&
            (identical(other.bidder, bidder) || other.bidder == bidder) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.makerExpanded, makerExpanded) ||
                other.makerExpanded == makerExpanded) &&
            (identical(other.openFrom, openFrom) ||
                other.openFrom == openFrom) &&
            (identical(other.openTo, openTo) || other.openTo == openTo) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.taker, taker) || other.taker == taker) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        orderId,
        contract,
        kind,
        maker,
        network,
        open,
        price,
        token,
        typename,
        bidAmount,
        bidder,
        currency,
        makerExpanded,
        openFrom,
        openTo,
        paidAmount,
        taker,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderComplexDtoCopyWith<_$_OrderComplexDto> get copyWith =>
      __$$_OrderComplexDtoCopyWithImpl<_$_OrderComplexDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderComplexDtoToJson(
      this,
    );
  }
}

abstract class _OrderComplexDto implements OrderComplexDto {
  const factory _OrderComplexDto(
      {required final String id,
      required final String orderId,
      required final String contract,
      required final OrderKind kind,
      required final String maker,
      required final String network,
      required final bool open,
      required final String price,
      required final TokenSimpleDto token,
      final String? typename,
      final String? bidAmount,
      final String? bidder,
      final OrderCurrencyDto? currency,
      final UserDto? makerExpanded,
      final String? openFrom,
      final String? openTo,
      final String? paidAmount,
      final String? taker,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_OrderComplexDto;

  factory _OrderComplexDto.fromJson(Map<String, dynamic> json) =
      _$_OrderComplexDto.fromJson;

  @override
  String get id;
  @override
  String get orderId;
  @override
  String get contract;
  @override
  OrderKind get kind;
  @override
  String get maker;
  @override
  String get network;
  @override
  bool get open;
  @override
  String get price;
  @override
  TokenSimpleDto get token;
  @override
  String? get typename;
  @override
  String? get bidAmount;
  @override
  String? get bidder;
  @override
  OrderCurrencyDto? get currency;
  @override
  UserDto? get makerExpanded;
  @override
  String? get openFrom;
  @override
  String? get openTo;
  @override
  String? get paidAmount;
  @override
  String? get taker;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_OrderComplexDtoCopyWith<_$_OrderComplexDto> get copyWith =>
      throw _privateConstructorUsedError;
}
