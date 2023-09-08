import 'package:app/core/data/event/dtos/event_ticket_pricing_dto/event_ticket_pricing_dto.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

class EventTicketPricing {
  final String? id;
  final double? amount;
  final Currency? currency;

  EventTicketPricing({
    this.id,
    this.amount,
    this.currency,
  });

  factory EventTicketPricing.fromDto(EventTicketPricingDto dto) =>
      EventTicketPricing(
        id: dto.id,
        amount: dto.amount,
        currency: dto.currency,
      );
}
