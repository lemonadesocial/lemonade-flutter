import 'package:app/core/data/event/dtos/event_payment_ticket_discount_dto/event_payment_ticket_discount_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_payment_ticket_discount.freezed.dart';

@freezed
class EventPaymentTicketDiscount with _$EventPaymentTicketDiscount {
  factory EventPaymentTicketDiscount({
    bool? active,
    String? code,
    double? ratio,
    DateTime? stamp,
    double? ticketCount,
    dynamic ticketCountMap,
    double? ticketLimitPer,
    double? ticketLimit,
    List<String>? ticketTypes,
    double? useCount,
    dynamic useCountMap,
    double? useLimit,
    double? useLimitPer,
  }) = _EventPaymentTicketDiscount;

  factory EventPaymentTicketDiscount.fromDto(
    EventPaymentTicketDiscountDto dto,
  ) =>
      EventPaymentTicketDiscount(
        active: dto.active,
        code: dto.code,
        ratio: dto.ratio,
        stamp: dto.stamp,
        ticketCount: dto.ticketCount,
        ticketCountMap: dto.ticketCountMap,
        ticketLimitPer: dto.ticketLimitPer,
        ticketLimit: dto.ticketLimit,
        ticketTypes: dto.ticketTypes,
        useCount: dto.useCount,
        useCountMap: dto.useCountMap,
        useLimit: dto.useLimit,
        useLimitPer: dto.useLimitPer,
      );
}
