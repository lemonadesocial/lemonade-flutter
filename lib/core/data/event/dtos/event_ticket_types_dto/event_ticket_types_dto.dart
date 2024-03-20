import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/data/event/dtos/event_ticket_category_dto/event_ticket_category_dto.dart';
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
    bool? limited,
    bool? private,
    bool? whitelisted,
    @JsonKey(name: 'address_required') bool? addressRequired,
    List<EventTicketPriceDto>? prices,
    @JsonKey(name: 'default') bool? isDefault,
    String? description,
    @JsonKey(name: 'description_line') String? descriptionLine,
    bool? discountable,
    List<String>? externalIds,
    int? limit,
    List<EventOfferDto>? offers,
    List<String>? photos,
    String? title,
    @JsonKey(name: 'photos_expanded') List<DbFileDto>? photosExpanded,
    EventTicketCategoryDto? category,
  }) = _PurchasableTicketTypeDto;

  factory PurchasableTicketTypeDto.fromJson(Map<String, dynamic> json) =>
      _$PurchasableTicketTypeDtoFromJson(json);
}

@freezed
class EventTicketTypeDto with _$EventTicketTypeDto {
  factory EventTicketTypeDto({
    @JsonKey(name: '_id') String? id,
    bool? active,
    bool? private,
    bool? limited,
    @JsonKey(name: 'address_required') bool? addressRequired,
    List<EventTicketPriceDto>? prices,
    @JsonKey(name: 'default') bool? isDefault,
    String? description,
    @JsonKey(name: 'description_line') String? descriptionLine,
    bool? discountable,
    List<String>? externalIds,
    int? limit,
    List<EventOfferDto>? offers,
    List<String>? photos,
    String? title,
    @JsonKey(name: 'photos_expanded') List<DbFileDto>? photosExpanded,
    @JsonKey(name: 'ticket_limit') double? ticketLimit,
    @JsonKey(name: 'ticket_count') double? ticketCount,
    @JsonKey(name: 'limited_whitelist_users')
    List<WhitelistUserInfoDto>? limitedWhitelistUsers,
    EventTicketCategoryDto? category,
  }) = _EventTicketTypeDto;

  factory EventTicketTypeDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketTypeDtoFromJson(json);
}

@freezed
class EventTicketPriceDto with _$EventTicketPriceDto {
  const factory EventTicketPriceDto({
    String? cost,
    String? currency,
    String? network,
    @JsonKey(name: 'default') bool? isDefault,
  }) = _EventTicketPriceDto;

  factory EventTicketPriceDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketPriceDtoFromJson(json);
}

@freezed
class WhitelistUserInfoDto with _$WhitelistUserInfoDto {
  factory WhitelistUserInfoDto({
    @JsonKey(name: '_id') String? id,
    String? email,
  }) = _WhitelistUserInfoDto;

  factory WhitelistUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$WhitelistUserInfoDtoFromJson(json);
}
