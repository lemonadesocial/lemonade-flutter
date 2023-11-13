import 'package:app/core/data/event/dtos/event_tickets_pricing_info_dto/event_tickets_pricing_info_dto.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';

class EventTicketsPricingInfo {
  final String? discount;
  final String? subTotal;
  final String? total;
  final double? fiatDiscount;
  final double? fiatSubTotal;
  final double? fiatTotal;
  final BigInt? blockchainDiscount;
  final BigInt? blockchainSubTotal;
  final BigInt? blockchainTotal;
  final List<PaymentAccount>? paymentAccounts;

  const EventTicketsPricingInfo({
    this.discount,
    this.subTotal,
    this.total,
    this.fiatDiscount,
    this.fiatSubTotal,
    this.fiatTotal,
    this.blockchainDiscount,
    this.blockchainSubTotal,
    this.blockchainTotal,
    this.paymentAccounts,
  });

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
        blockchainDiscount:
            dto.discount != null ? BigInt.parse(dto.discount!) : null,
        blockchainSubTotal:
            dto.subtotal != null ? BigInt.parse(dto.subtotal!) : null,
        blockchainTotal: dto.total != null ? BigInt.parse(dto.total!) : null,
        paymentAccounts: List.from(dto.paymentAccounts ?? [])
            .map((item) => PaymentAccount.fromDto(item))
            .toList(),
      );
}
