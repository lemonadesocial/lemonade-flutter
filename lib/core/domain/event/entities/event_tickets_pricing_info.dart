import 'package:app/core/data/event/dtos/event_tickets_pricing_info_dto/event_tickets_pricing_info_dto.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

class EventTicketsPricingInfo {
  final Currency? currency;
  final double? discount;
  final double? subTotal;
  final double? total;

  const EventTicketsPricingInfo({
    this.currency,
    this.discount,
    this.subTotal,
    this.total,
  });

  factory EventTicketsPricingInfo.fromDto(EventTicketsPricingInfoDto dto) =>
      EventTicketsPricingInfo(
        currency: dto.currency,
        discount: dto.discount,
        subTotal: dto.subTotal,
        total: dto.total,
      );
}
