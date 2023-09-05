import 'package:app/core/data/token/dtos/token_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/token/token_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_dtos.freezed.dart';
part 'order_dtos.g.dart';

@freezed
class OrderComplexDto with _$OrderComplexDto {
  const factory OrderComplexDto({
    required String id,
    required String orderId,
    required String contract,
    required OrderKind kind,
    required String maker,
    required String network,
    required bool open,
    required String price,
    required TokenSimpleDto token,
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
    DateTime? updatedAt,
  }) = _OrderComplexDto;

  factory OrderComplexDto.fromJson(Map<String, dynamic> json) =>
      _$OrderComplexDtoFromJson(json);
}
