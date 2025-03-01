import 'package:app/core/data/payment/dtos/billing_info_dto/billing_info_dto.dart';
import 'package:app/core/data/payment/dtos/buyer_info_dto/buyer_info_dto.dart';
import 'package:app/core/data/payment/dtos/crypto_payment_info_dto/crypto_payment_info_dto.dart';
import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/data/payment/dtos/stripe_payment_info_dto/stripe_payment_info_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_guest_payment_dto.freezed.dart';
part 'event_guest_payment_dto.g.dart';

@freezed
class EventGuestPaymentDto with _$EventGuestPaymentDto {
  factory EventGuestPaymentDto({
    @JsonKey(name: '_id') required String id,
    required Map<String, dynamic> stamps,
    required String amount,
    String? fee,
    required String currency,
    required Enum$NewPaymentState state,
    String? user,
    @JsonKey(name: 'buyer_info') BuyerInfoDto? buyerInfo,
    required String account,
    @JsonKey(name: 'ref_data') Map<String, dynamic>? refData,
    @JsonKey(name: 'billing_info') BillingInfoDto? billingInfo,
    @JsonKey(name: 'transfer_metadata') Map<String, dynamic>? transferMetadata,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
    @JsonKey(name: 'failure_reason') String? failureReason,
    @JsonKey(name: 'attempting_refund') bool? attemptingRefund,
    @JsonKey(name: 'account_expanded') PaymentAccountDto? accountExpanded,
    @JsonKey(name: 'due_amount') String? dueAmount,
    @JsonKey(name: 'buyer_user') UserDto? buyerUser,
    @JsonKey(name: 'formatted_due_amount') String? formattedDueAmount,
    @JsonKey(name: 'formatted_total_amount') String? formattedTotalAmount,
    @JsonKey(name: 'formatted_discount_amount') String? formattedDiscountAmount,
    @JsonKey(name: 'formatted_fee_amount') String? formattedFeeAmount,
    @JsonKey(name: 'stripe_payment_info')
    StripePaymentInfoDto? stripePaymentInfo,
    @JsonKey(name: 'crypto_payment_info')
    CryptoPaymentInfoDto? cryptoPaymentInfo,
  }) = _EventGuestPaymentDto;

  factory EventGuestPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$EventGuestPaymentDtoFromJson(json);
}
