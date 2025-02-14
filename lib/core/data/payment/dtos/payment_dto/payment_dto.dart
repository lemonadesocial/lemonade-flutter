import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/data/payment/dtos/billing_info_dto/billing_info_dto.dart';
import 'package:app/core/data/payment/dtos/buyer_info_dto/buyer_info_dto.dart';
import 'package:app/core/data/payment/dtos/crypto_payment_info_dto/crypto_payment_info_dto.dart';
import 'package:app/core/data/payment/dtos/stripe_payment_info_dto/stripe_payment_info_dto.dart';
import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_dto.freezed.dart';
part 'payment_dto.g.dart';

@freezed
class PaymentDto with _$PaymentDto {
  const factory PaymentDto({
    @JsonKey(name: '_id') String? id,
    String? user,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
    @JsonKey(name: 'transfer_metadata') Map<String, dynamic>? transferMetadata,
    Enum$NewPaymentState? state,
    Map<String, DateTime>? stamps,
    @JsonKey(name: 'failure_reason') String? failureReason,
    String? currency,
    @JsonKey(name: 'billing_info') BillingInfoDto? billingInfo,
    String? amount,
    @JsonKey(name: 'account_expanded') PaymentAccountDto? accountExpanded,
    String? account,
    @JsonKey(name: 'due_amount') String? dueAmount,
    @JsonKey(name: 'ticket_types_expanded')
    List<EventTicketTypeDto?>? ticketTypesExpanded,
    @JsonKey(name: 'tickets') List<EventTicketDto?>? tickets,
    @JsonKey(name: 'ref_data') Map<String, dynamic>? refData,
    @JsonKey(name: 'buyer_info') BuyerInfoDto? buyerInfo,
    @JsonKey(name: 'buyer_user') UserDto? buyerUser,
    @JsonKey(name: 'formatted_discount_amount') String? formattedDiscountAmount,
    @JsonKey(name: 'formatted_due_amount') String? formattedDueAmount,
    @JsonKey(name: 'formatted_fee_amount') String? formattedFeeAmount,
    @JsonKey(name: 'formatted_total_amount') String? formattedTotalAmount,
    @JsonKey(name: 'crypto_payment_info')
    CryptoPaymentInfoDto? cryptoPaymentInfo,
    @JsonKey(name: 'stripe_payment_info')
    StripePaymentInfoDto? stripePaymentInfo,
  }) = _PaymentDto;

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);
}
