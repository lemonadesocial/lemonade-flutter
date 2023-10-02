import 'package:app/core/data/event/dtos/event_payment_ticket_type_dto/event_payment_ticket_type_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';

class EventPaymentTicketType {
  final String? id;
  final bool? active;
  final bool? addressRequired;
  final int? cost;
  final bool? isDefault;
  final String? description;
  final String? descriptionLine;
  final bool? discountable;
  final List<String>? externalIds;
  final int? limit;
  final List<EventOffer>? offers;
  final List<String>? photos;
  final String? title;

  const EventPaymentTicketType({
    this.id,
    this.active,
    this.addressRequired,
    this.cost,
    this.isDefault,
    this.description,
    this.descriptionLine,
    this.discountable,
    this.externalIds,
    this.limit,
    this.offers,
    this.photos,
    this.title,
  });

  factory EventPaymentTicketType.fromDto(EventPaymentTicketTypeDto dto) =>
      EventPaymentTicketType(
        id: dto.id,
        active: dto.active,
        addressRequired: dto.addressRequired,
        cost: dto.cost,
        isDefault: dto.isDefault,
        description: dto.description,
        descriptionLine: dto.descriptionLine,
        discountable: dto.discountable,
        externalIds: dto.externalIds,
        limit: dto.limit,
        offers: dto.offers != null
            ? List.from(dto.offers ?? [])
                .map((item) => EventOffer.fromDto(item))
                .toList()
            : [],
        photos: dto.photos,
        title: dto.title,
      );
}
