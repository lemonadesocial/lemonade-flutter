import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
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
    bool? isDefault,
    String? description,
    String? descriptionLine,
    bool? discountable,
    List<String>? externalIds,
    int? limit,
    List<EventOffer>? offers,
    List<String>? photos,
    String? title,
    List<EventTicketPrice>? prices,
    Currency? defaultCurrency,
    EventTicketPrice? defaultPrice,
  }) = _PurchasableTicketType;

  factory PurchasableTicketType.fromDto(PurchasableTicketTypeDto dto) =>
      PurchasableTicketType(
        id: dto.id,
        active: dto.active,
        addressRequired: dto.addressRequired,
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
        prices: List.from(dto.prices ?? [])
            .map((item) => EventTicketPrice.fromDto(item))
            .toList(),
      );
}

class EventTicketPrice {
  final String? cost;
  final BigInt? cryptoCost;
  final double? fiatCost;
  final SupportedPaymentNetwork? network;
  final Currency? currency;

  EventTicketPrice({
    this.cost,
    this.cryptoCost,
    this.fiatCost,
    this.network,
    this.currency,
  });

  factory EventTicketPrice.fromDto(EventTicketPriceDto dto) => EventTicketPrice(
        cost: dto.cost,
        fiatCost: dto.cost != null ? double.tryParse(dto.cost!) : null,
        cryptoCost: dto.cost != null ? BigInt.tryParse(dto.cost!) : null,
        network: dto.network,
        currency: dto.currency,
      );
}
