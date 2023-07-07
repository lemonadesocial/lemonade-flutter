// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderComplexDto _$$_OrderComplexDtoFromJson(Map<String, dynamic> json) =>
    _$_OrderComplexDto(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      contract: json['contract'] as String,
      kind: $enumDecode(_$OrderKindEnumMap, json['kind']),
      maker: json['maker'] as String,
      network: json['network'] as String,
      open: json['open'] as bool,
      price: json['price'] as String,
      token: TokenSimpleDto.fromJson(json['token'] as Map<String, dynamic>),
      typename: json['typename'] as String?,
      bidAmount: json['bidAmount'] as String?,
      bidder: json['bidder'] as String?,
      currency: json['currency'] == null
          ? null
          : OrderCurrencyDto.fromJson(json['currency'] as Map<String, dynamic>),
      makerExpanded: json['makerExpanded'] == null
          ? null
          : UserDto.fromJson(json['makerExpanded'] as Map<String, dynamic>),
      openFrom: json['openFrom'] as String?,
      openTo: json['openTo'] as String?,
      paidAmount: json['paidAmount'] as String?,
      taker: json['taker'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_OrderComplexDtoToJson(_$_OrderComplexDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'contract': instance.contract,
      'kind': _$OrderKindEnumMap[instance.kind]!,
      'maker': instance.maker,
      'network': instance.network,
      'open': instance.open,
      'price': instance.price,
      'token': instance.token,
      'typename': instance.typename,
      'bidAmount': instance.bidAmount,
      'bidder': instance.bidder,
      'currency': instance.currency,
      'makerExpanded': instance.makerExpanded,
      'openFrom': instance.openFrom,
      'openTo': instance.openTo,
      'paidAmount': instance.paidAmount,
      'taker': instance.taker,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$OrderKindEnumMap = {
  OrderKind.AUCTION: 'AUCTION',
  OrderKind.DIRECT: 'DIRECT',
};
