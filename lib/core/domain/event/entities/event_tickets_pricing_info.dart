import 'package:app/core/data/event/dtos/event_tickets_pricing_info_dto/event_tickets_pricing_info_dto.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_tickets_pricing_info.freezed.dart';

@freezed
class EventTicketsPricingInfo with _$EventTicketsPricingInfo {
  EventTicketsPricingInfo._();

  factory EventTicketsPricingInfo({
    String? discount,
    String? subTotal,
    String? total,
    double? fiatDiscount,
    double? fiatSubTotal,
    double? fiatTotal,
    BigInt? cryptoDiscount,
    BigInt? cryptoSubTotal,
    BigInt? cryptoTotal,
    List<PaymentAccount>? paymentAccounts,
    String? promoCode,
  }) = _EventTicketsPricingInfo;

  factory EventTicketsPricingInfo.fromDto(EventTicketsPricingInfoDto dto) =>
      EventTicketsPricingInfo(
        discount: dto.discount,
        subTotal: dto.subtotal,
        total: dto.total,
        fiatDiscount:
            dto.discount != null ? double.tryParse(dto.discount!) : null,
        fiatSubTotal:
            dto.subtotal != null ? double.tryParse(dto.subtotal!) : null,
        fiatTotal: dto.total != null ? double.tryParse(dto.total!) : null,
        cryptoDiscount:
            dto.discount != null ? BigInt.parse(dto.discount!) : null,
        cryptoSubTotal:
            dto.subtotal != null ? BigInt.parse(dto.subtotal!) : null,
        cryptoTotal: dto.total != null ? BigInt.parse(dto.total!) : null,
        paymentAccounts: List.from(dto.paymentAccounts ?? [])
            .map((item) => PaymentAccount.fromDto(item))
            .toList(),
      );
}
