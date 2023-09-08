import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_pricing_dto.g.dart';
part 'event_ticket_pricing_dto.freezed.dart';

@freezed
class EventTicketPricingDto with _$EventTicketPricingDto {
  factory EventTicketPricingDto({
    @JsonKey(name: '_id') id,
    double? amount,
    Currency? currency,
  }) = _EventTicketPricingDto;

  factory EventTicketPricingDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketPricingDtoFromJson(json);
}
