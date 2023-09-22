import 'package:app/core/data/event/dtos/event_list_ticket_types_dto/event_list_ticket_types_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';

class EventListTicketTypes {
  final TicketDiscount? discount;
  final int? limit;
  final List<PurchasableTicketType>? ticketTypes;

  const EventListTicketTypes({
    this.discount,
    this.limit,
    this.ticketTypes,
  });

  factory EventListTicketTypes.fromDto(EventListTicketTypesDto dto) =>
      EventListTicketTypes(
        discount:
            dto.discount != null ? TicketDiscount.fromDto(dto.discount!) : null,
        limit: dto.limit,
        ticketTypes: dto.ticketTypes != null
            ? List.from(dto.ticketTypes ?? [])
                .map((item) => PurchasableTicketType.fromDto(item))
                .toList()
            : [],
      );
}

class TicketDiscount {
  final String? discount;
  final int? limit;
  final double? ratio;

  const TicketDiscount({
    this.discount,
    this.limit,
    this.ratio,
  });

  factory TicketDiscount.fromDto(TicketDiscountDto dto) => TicketDiscount(
        discount: dto.discount,
        limit: dto.limit,
        ratio: dto.ratio,
      );
}

class PurchasableTicketType {
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

  const PurchasableTicketType({
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

  factory PurchasableTicketType.fromDto(PurchasableTicketTypeDto dto) =>
      PurchasableTicketType(
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
