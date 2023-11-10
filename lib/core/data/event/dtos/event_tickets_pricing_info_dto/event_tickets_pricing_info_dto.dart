import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_tickets_pricing_info_dto.freezed.dart';
part 'event_tickets_pricing_info_dto.g.dart';

@freezed
class EventTicketsPricingInfoDto with _$EventTicketsPricingInfoDto {
  factory EventTicketsPricingInfoDto({
    String? discount,
    String? subtotal,
    String? total,
    @JsonKey(name: 'payment_accounts') List<PaymentAccountDto>? paymentAccounts,
  }) = _EventTicketsPricingInfoDto;

  factory EventTicketsPricingInfoDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketsPricingInfoDtoFromJson(json);
}
