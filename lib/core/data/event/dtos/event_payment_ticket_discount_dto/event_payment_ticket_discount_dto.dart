import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_payment_ticket_discount_dto.freezed.dart';
part 'event_payment_ticket_discount_dto.g.dart';

@freezed
class EventPaymentTicketDiscountDto with _$EventPaymentTicketDiscountDto {
  factory EventPaymentTicketDiscountDto({
    bool? active,
    String? code,
    double? ratio,
    DateTime? stamp,
    @JsonKey(name: "ticket_count") double? ticketCount,
    @JsonKey(name: "ticket_count_map") dynamic ticketCountMap,
    @JsonKey(name: "ticket_limit_per") double? ticketLimitPer,
    @JsonKey(name: "ticket_limit") double? ticketLimit,
    @JsonKey(name: "ticket_types") List<String>? ticketTypes,
    @JsonKey(name: "use_count") double? useCount,
    @JsonKey(name: "use_count_map") dynamic useCountMap,
    @JsonKey(name: "use_limit") double? useLimit,
    @JsonKey(name: "use_limit_per") double? useLimitPer,
  }) = _EventPaymentTicketDiscountDto;

  factory EventPaymentTicketDiscountDto.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentTicketDiscountDtoFromJson(json);
}
