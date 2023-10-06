import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_types_dto.freezed.dart';
part 'event_ticket_types_dto.g.dart';

@freezed
class EventTicketTypesResponseDto with _$EventTicketTypesResponseDto {
  factory EventTicketTypesResponseDto({
    TicketDiscountDto? discount,
    int? limit,
    @JsonKey(name: 'ticket_types') List<PurchasableTicketTypeDto>? ticketTypes,
  }) = _EventTicketTypesResponseDto;

  factory EventTicketTypesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketTypesResponseDtoFromJson(json);
}

@freezed
class TicketDiscountDto with _$TicketDiscountDto {
  factory TicketDiscountDto({
    String? discount,
    int? limit,
    double? ratio,
  }) = _TicketDiscountDto;

  factory TicketDiscountDto.fromJson(Map<String, dynamic> json) =>
      _$TicketDiscountDtoFromJson(json);
}

@freezed
class PurchasableTicketTypeDto with _$PurchasableTicketTypeDto {
  factory PurchasableTicketTypeDto({
    @JsonKey(name: '_id') String? id,
    bool? active,
    @JsonKey(name: 'address_required') bool? addressRequired,
    int? cost,
    @JsonKey(name: 'default') bool? isDefault,
    String? description,
    @JsonKey(name: 'description_line') String? descriptionLine,
    bool? discountable,
    List<String>? externalIds,
    int? limit,
    List<EventOfferDto>? offers,
    List<String>? photos,
    String? title,
  }) = _PurchasableTicketTypeDto;

  factory PurchasableTicketTypeDto.fromJson(Map<String, dynamic> json) =>
      _$PurchasableTicketTypeDtoFromJson(json);
}
