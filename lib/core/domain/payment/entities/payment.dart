import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/billing_info/billing_info.dart';
import 'package:app/core/domain/payment/entities/buyer_info/buyer_info.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/crypto_payment_info/crypto_payment_info.dart';
import 'package:app/core/domain/payment/entities/stripe_payment_info/stripe_payment_info.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  Payment._();

  factory Payment({
    String? id,
    String? user,
    Map<String, dynamic>? transferParams,
    Map<String, dynamic>? transferMetadata,
    Enum$NewPaymentState? state,
    Map<String, DateTime>? stamps,
    String? failureReason,
    String? currency,
    BillingInfo? billingInfo,
    String? amount,
    PaymentAccount? accountExpanded,
    String? account,
    String? dueAmount,
    List<EventTicketType>? ticketTypesExpanded,
    List<EventTicket>? tickets,
    Map<String, dynamic>? refData,
    BuyerInfo? buyerInfo,
    User? buyerUser,
    String? formattedDiscountAmount,
    String? formattedDueAmount,
    String? formattedFeeAmount,
    String? formattedTotalAmount,
    CryptoPaymentInfo? cryptoPaymentInfo,
    StripePaymentInfo? stripePaymentInfo,
  }) = _Payment;

  String get buyerName =>
      buyerInfo?.name ?? buyerUser?.name ?? buyerUser?.displayName ?? '';

  String get buyerEmail => buyerInfo?.email ?? buyerUser?.email ?? '';

  String get buyerAvatar => buyerUser?.imageAvatar ?? '';

  String get discountCode => refData?['discount'] ?? '';

  factory Payment.fromDto(PaymentDto dto) => Payment(
        id: dto.id,
        user: dto.user,
        transferParams: dto.transferParams,
        transferMetadata: dto.transferMetadata,
        state: dto.state,
        stamps: dto.stamps,
        failureReason: dto.failureReason,
        currency: dto.currency,
        billingInfo: dto.billingInfo != null
            ? BillingInfo.fromDto(dto.billingInfo!)
            : null,
        amount: dto.amount,
        accountExpanded: dto.accountExpanded != null
            ? PaymentAccount.fromDto(dto.accountExpanded!)
            : null,
        account: dto.account,
        dueAmount: dto.dueAmount,
        ticketTypesExpanded: (dto.ticketTypesExpanded ?? [])
            .where((element) => element != null)
            .map((item) => EventTicketType.fromDto(item!))
            .toList(),
        tickets: (dto.tickets ?? [])
            .where((element) => element != null)
            .map((item) => EventTicket.fromDto(item!))
            .toList(),
        refData: dto.refData,
        buyerInfo:
            dto.buyerInfo != null ? BuyerInfo.fromDto(dto.buyerInfo!) : null,
        buyerUser: dto.buyerUser != null ? User.fromDto(dto.buyerUser!) : null,
        formattedDiscountAmount: dto.formattedDiscountAmount,
        formattedDueAmount: dto.formattedDueAmount,
        formattedFeeAmount: dto.formattedFeeAmount,
        formattedTotalAmount: dto.formattedTotalAmount,
        cryptoPaymentInfo: dto.cryptoPaymentInfo != null
            ? CryptoPaymentInfo.fromDto(dto.cryptoPaymentInfo!)
            : null,
        stripePaymentInfo: dto.stripePaymentInfo != null
            ? StripePaymentInfo.fromDto(dto.stripePaymentInfo!)
            : null,
      );

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
