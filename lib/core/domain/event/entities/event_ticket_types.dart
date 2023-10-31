import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_types.freezed.dart';

class EventTicketTypesResponse {
  final TicketDiscount? discount;
  final int? limit;
  final List<PurchasableTicketType>? ticketTypes;

  const EventTicketTypesResponse({
    this.discount,
    this.limit,
    this.ticketTypes,
  });

  factory EventTicketTypesResponse.fromDto(
    EventTicketTypesResponseDto dto,
  ) =>
      EventTicketTypesResponse(
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

@freezed
class PurchasableTicketType with _$PurchasableTicketType {
  factory PurchasableTicketType({
    String? id,
    bool? active,
    bool? addressRequired,
    int? cost,
    bool? isDefault,
    String? description,
    String? descriptionLine,
    bool? discountable,
    List<String>? externalIds,
    int? limit,
    List<EventOffer>? offers,
    List<String>? photos,
    String? title,
    @Default(1) int count,
  }) = _PurchasableTicketType;

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
