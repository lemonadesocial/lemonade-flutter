// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_orders_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderWhereComplex _$$_OrderWhereComplexFromJson(Map<String, dynamic> json) =>
    _$_OrderWhereComplex(
      makerIn: (json['maker_in'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      openEq: json['open_eq'] as bool?,
      takerExists: json['taker_exists'] as bool?,
    );

Map<String, dynamic> _$$_OrderWhereComplexToJson(
    _$_OrderWhereComplex instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maker_in', instance.makerIn);
  writeNotNull('open_eq', instance.openEq);
  writeNotNull('taker_exists', instance.takerExists);
  return val;
}

_$_OrderSort _$$_OrderSortFromJson(Map<String, dynamic> json) => _$_OrderSort(
      by: $enumDecodeNullable(_$OrderSortByEnumMap, json['by']),
      direction: $enumDecodeNullable(_$SortDirectionEnumMap, json['direction']),
    );

Map<String, dynamic> _$$_OrderSortToJson(_$_OrderSort instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('by', _$OrderSortByEnumMap[instance.by]);
  writeNotNull('direction', _$SortDirectionEnumMap[instance.direction]);
  return val;
}

const _$OrderSortByEnumMap = {
  OrderSortBy.bidAmount: 'bidAmount',
  OrderSortBy.bidder: 'bidder',
  OrderSortBy.contract: 'contract',
  OrderSortBy.createdAt: 'createdAt',
  OrderSortBy.currency: 'currency',
  OrderSortBy.id: 'id',
  OrderSortBy.kind: 'kind',
  OrderSortBy.maker: 'maker',
  OrderSortBy.network: 'network',
  OrderSortBy.open: 'open',
  OrderSortBy.openFrom: 'openFrom',
  OrderSortBy.openTo: 'openTo',
  OrderSortBy.orderId: 'orderId',
  OrderSortBy.paidAmount: 'paidAmount',
  OrderSortBy.price: 'price',
  OrderSortBy.taker: 'taker',
  OrderSortBy.updatedAt: 'updatedAt',
};

const _$SortDirectionEnumMap = {
  SortDirection.ASC: 'ASC',
  SortDirection.DESC: 'DESC',
};

_$_WatchOrdersInput _$$_WatchOrdersInputFromJson(Map<String, dynamic> json) =>
    _$_WatchOrdersInput(
      where: json['where'] == null
          ? null
          : OrderWhereComplex.fromJson(json['where'] as Map<String, dynamic>),
      sort: json['sort'] == null
          ? null
          : OrderSort.fromJson(json['sort'] as Map<String, dynamic>),
      query: json['query'] as bool?,
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$$_WatchOrdersInputToJson(_$_WatchOrdersInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('where', instance.where?.toJson());
  writeNotNull('sort', instance.sort?.toJson());
  writeNotNull('query', instance.query);
  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  return val;
}
