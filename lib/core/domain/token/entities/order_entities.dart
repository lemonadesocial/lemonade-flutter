import 'package:app/core/data/token/dtos/order_dtos.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/token_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';

class OrderComplex {
  final String id;
  final String orderId;
  final String contract;
  final OrderKind kind;
  final String maker;
  final String network;
  final bool open;
  final String price;
  final TokenSimple token;
  final String? typename;
  final String? bidAmount;
  final String? bidder;
  final OrderCurrency? currency;
  final User? makerExpanded;
  final String? openFrom;
  final String? openTo;
  final String? paidAmount;
  final String? taker;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderComplex({
    required this.id,
    required this.orderId,
    required this.contract,
    required this.createdAt,
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
    this.updatedAt,
  });

  factory OrderComplex.fromDto(OrderComplexDto dto) => OrderComplex(
    id: dto.id,
    orderId: dto.orderId,
    contract: dto.contract,
    kind: dto.kind,
    maker: dto.maker,
    network: dto.network,
    open: dto.open,
    price: dto.price,
    token: TokenSimple.fromDto(dto.token),
    typename: dto.typename,
    bidAmount: dto.bidAmount,
    bidder: dto.bidder,
    currency: dto.currency != null ? OrderCurrency.fromDto(dto.currency!) : null,
    makerExpanded: dto.makerExpanded != null ? User.fromDto(dto.makerExpanded!) : null,
    openFrom: dto.openFrom,
    openTo: dto.openTo,
    paidAmount: dto.paidAmount,
    taker: dto.taker,
    createdAt: dto.createdAt,
    updatedAt: dto.updatedAt,
  );
}
