import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_tickets_pricing_info_dto.freezed.dart';
part 'event_tickets_pricing_info_dto.g.dart';

@freezed
class EventTicketsPricingInfoDto with _$EventTicketsPricingInfoDto {
  factory EventTicketsPricingInfoDto({
    Currency? currency,
    double? discount,
    double? subtotal,
    double? total,
  }) = _EventTicketsPricingInfoDto;

  factory EventTicketsPricingInfoDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketsPricingInfoDtoFromJson(json);
}
