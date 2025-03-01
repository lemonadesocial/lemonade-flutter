import 'package:app/core/data/payment/dtos/event_guest_payment_dto/event_guest_payment_dto.dart';
import 'package:app/core/domain/payment/entities/billing_info/billing_info.dart';
import 'package:app/core/domain/payment/entities/buyer_info/buyer_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/crypto_payment_info/crypto_payment_info.dart';
import 'package:app/core/domain/payment/entities/stripe_payment_info/stripe_payment_info.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_guest_payment.freezed.dart';
part 'event_guest_payment.g.dart';

@freezed
class EventGuestPayment with _$EventGuestPayment {
  factory EventGuestPayment({
    required String id,
    required Map<String, dynamic> stamps,
    required String amount,
    String? fee,
    required String currency,
    required Enum$NewPaymentState state,
    String? user,
    BuyerInfo? buyerInfo,
    required String account,
    Map<String, dynamic>? refData,
    BillingInfo? billingInfo,
    Map<String, dynamic>? transferMetadata,
    Map<String, dynamic>? transferParams,
    String? failureReason,
    bool? attemptingRefund,
    PaymentAccount? accountExpanded,
    String? dueAmount,
    User? buyerUser,
    String? formattedDueAmount,
    String? formattedTotalAmount,
    String? formattedDiscountAmount,
    String? formattedFeeAmount,
    StripePaymentInfo? stripePaymentInfo,
    CryptoPaymentInfo? cryptoPaymentInfo,
  }) = _EventGuestPayment;

  factory EventGuestPayment.fromDto(EventGuestPaymentDto dto) =>
      EventGuestPayment(
        id: dto.id,
        stamps: dto.stamps,
        amount: dto.amount,
        fee: dto.fee,
        currency: dto.currency,
        state: dto.state,
        user: dto.user,
        buyerInfo:
            dto.buyerInfo != null ? BuyerInfo.fromDto(dto.buyerInfo!) : null,
        account: dto.account,
        refData: dto.refData,
        billingInfo: dto.billingInfo != null
            ? BillingInfo.fromDto(dto.billingInfo!)
            : null,
        transferMetadata: dto.transferMetadata,
        transferParams: dto.transferParams,
        failureReason: dto.failureReason,
        attemptingRefund: dto.attemptingRefund,
        accountExpanded: dto.accountExpanded != null
            ? PaymentAccount.fromDto(dto.accountExpanded!)
            : null,
        dueAmount: dto.dueAmount,
        buyerUser: dto.buyerUser != null ? User.fromDto(dto.buyerUser!) : null,
        formattedDueAmount: dto.formattedDueAmount,
        formattedTotalAmount: dto.formattedTotalAmount,
        formattedDiscountAmount: dto.formattedDiscountAmount,
        formattedFeeAmount: dto.formattedFeeAmount,
        stripePaymentInfo: dto.stripePaymentInfo != null
            ? StripePaymentInfo.fromDto(dto.stripePaymentInfo!)
            : null,
        cryptoPaymentInfo: dto.cryptoPaymentInfo != null
            ? CryptoPaymentInfo.fromDto(dto.cryptoPaymentInfo!)
            : null,
      );

  factory EventGuestPayment.fromJson(Map<String, dynamic> json) =>
      _$EventGuestPaymentFromJson(json);
}
