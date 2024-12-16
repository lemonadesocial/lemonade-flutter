import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_category.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_types.freezed.dart';
part 'event_ticket_types.g.dart';

@freezed
class EventTicketTypesResponse with _$EventTicketTypesResponse {
  const EventTicketTypesResponse._();

  factory EventTicketTypesResponse({
    TicketDiscount? discount,
    int? limit,
    List<PurchasableTicketType>? ticketTypes,
  }) = _EventTicketTypesResponse;

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

@freezed
class TicketDiscount with _$TicketDiscount {
  const TicketDiscount._();

  factory TicketDiscount({
    String? discount,
    int? limit,
    double? ratio,
  }) = _TicketDiscount;

  factory TicketDiscount.fromDto(TicketDiscountDto dto) => TicketDiscount(
        discount: dto.discount,
        limit: dto.limit,
        ratio: dto.ratio,
      );

  factory TicketDiscount.fromJson(Map<String, dynamic> json) =>
      _$TicketDiscountFromJson(json);
}

// Used for Guest
@freezed
class PurchasableTicketType with _$PurchasableTicketType {
  const PurchasableTicketType._();

  @JsonSerializable(explicitToJson: true)
  factory PurchasableTicketType({
    String? id,
    bool? active,
    bool? limited,
    bool? private,
    bool? whitelisted,
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
    String? defaultCurrency,
    EventTicketPrice? defaultPrice,
    List<DbFile>? photosExpanded,
    String? category,
    EventTicketCategory? categoryExpanded,
  }) = _PurchasableTicketType;

  factory PurchasableTicketType.fromDto(PurchasableTicketTypeDto dto) =>
      PurchasableTicketType(
        id: dto.id,
        active: dto.active,
        limited: dto.limited,
        private: dto.private,
        whitelisted: dto.whitelisted,
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
        photosExpanded: List.from(dto.photosExpanded ?? [])
            .map((item) => DbFile.fromDto(item))
            .toList(),
        category: dto.category,
        categoryExpanded: dto.categoryExpanded != null
            ? EventTicketCategory.fromDto(dto.categoryExpanded!)
            : null,
      );

  factory PurchasableTicketType.fromJson(Map<String, dynamic> json) =>
      _$PurchasableTicketTypeFromJson(json);
}

// Used for Host
@freezed
class EventTicketType with _$EventTicketType {
  const EventTicketType._();

  @JsonSerializable(explicitToJson: true)
  factory EventTicketType({
    String? id,
    bool? active,
    bool? private,
    bool? limited,
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
    String? defaultCurrency,
    EventTicketPrice? defaultPrice,
    List<DbFile>? photosExpanded,
    double? ticketLimit,
    double? ticketLimitPer,
    double? ticketCount,
    List<WhitelistUserInfo>? limitedWhitelistUsers,
    String? category,
    EventTicketCategory? categoryExpanded,
  }) = _EventTicketType;

  factory EventTicketType.fromDto(EventTicketTypeDto dto) => EventTicketType(
        id: dto.id,
        active: dto.active,
        private: dto.private,
        limited: dto.limited,
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
        photosExpanded: List.from(dto.photosExpanded ?? [])
            .map((item) => DbFile.fromDto(item))
            .toList(),
        ticketLimit: dto.ticketLimit,
        ticketLimitPer: dto.ticketLimitPer,
        ticketCount: dto.ticketCount,
        limitedWhitelistUsers: List.from(dto.limitedWhitelistUsers ?? [])
            .map((item) => WhitelistUserInfo.fromDto(item))
            .toList(),
        category: dto.category,
        categoryExpanded: dto.categoryExpanded != null
            ? EventTicketCategory.fromDto(dto.categoryExpanded!)
            : null,
      );

  factory EventTicketType.fromJson(Map<String, dynamic> json) =>
      _$EventTicketTypeFromJson(json);
}

@freezed
class EventTicketPrice with _$EventTicketPrice {
  const EventTicketPrice._();

  factory EventTicketPrice({
    String? cost,
    BigInt? cryptoCost,
    double? fiatCost,
    String? currency,
    bool? isDefault,
    List<String?>? paymentAccounts,
    List<PaymentAccount>? paymentAccountsExpanded,
  }) = _EventTicketPrice;

  bool get isCrypto =>
      paymentAccountsExpanded?.isNotEmpty == true &&
      (paymentAccountsExpanded?.every(
            (paymentAccount) =>
                paymentAccount.type != PaymentAccountType.digital,
          ) ??
          false);

  bool get isFiat =>
      // this handle where free ticket not have payment accounts
      paymentAccountsExpanded?.isEmpty == true ||
      (paymentAccountsExpanded?.every(
            (paymentAccount) =>
                paymentAccount.type == PaymentAccountType.digital,
          ) ??
          false);

  bool get isFree => cost == '0';

  List<String> get supportedNetworks {
    if (isFiat) return [];

    return paymentAccountsExpanded
            ?.map((paymentAccount) => paymentAccount.accountInfo?.network)
            .whereType<String>()
            .toList() ??
        [];
  }

  factory EventTicketPrice.fromDto(EventTicketPriceDto dto) => EventTicketPrice(
        cost: dto.cost,
        fiatCost: dto.cost != null ? double.tryParse(dto.cost!) : null,
        cryptoCost: dto.cost != null ? BigInt.tryParse(dto.cost!) : null,
        currency: dto.currency,
        isDefault: dto.isDefault,
        paymentAccounts: dto.paymentAccounts,
        paymentAccountsExpanded: dto.paymentAccountsExpanded != null
            ? List.from(dto.paymentAccountsExpanded ?? [])
                .map((item) => PaymentAccount.fromDto(item))
                .toList()
            : [],
      );

  factory EventTicketPrice.fromJson(Map<String, dynamic> json) =>
      _$EventTicketPriceFromJson(json);
}

@freezed
class WhitelistUserInfo with _$WhitelistUserInfo {
  const WhitelistUserInfo._();

  factory WhitelistUserInfo({
    String? id,
    String? email,
  }) = _WhitelistUserInfo;

  factory WhitelistUserInfo.fromDto(WhitelistUserInfoDto dto) =>
      WhitelistUserInfo(
        id: dto.id,
        email: dto.email,
      );

  factory WhitelistUserInfo.fromJson(Map<String, dynamic> json) =>
      _$WhitelistUserInfoFromJson(json);
}
