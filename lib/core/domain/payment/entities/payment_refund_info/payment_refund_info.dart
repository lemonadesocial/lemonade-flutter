import 'package:app/core/data/payment/dtos/payment_refund_info_dto/payment_refund_info_dto.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/refund_policy/refund_policy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_refund_info.freezed.dart';

@freezed
class PaymentRefundInfo with _$PaymentRefundInfo {
  PaymentRefundInfo._();

  factory PaymentRefundInfo({
    String? id,
    String? amount,
    String? currency,
    Enum$NewPaymentState? state,
    bool? attemptingRefund,
    RefundPolicy? refundPolicy,
    bool? refundRequirementsMet,
    PaymentAccount? paymentAccount,
  }) = _PaymentRefundInfo;

  factory PaymentRefundInfo.fromDto(PaymentRefundInfoDto dto) =>
      PaymentRefundInfo(
        id: dto.id,
        amount: dto.amount,
        currency: dto.currency,
        state: dto.state,
        attemptingRefund: dto.attemptingRefund,
        refundPolicy: dto.refundPolicy != null
            ? RefundPolicy.fromDto(dto.refundPolicy!)
            : null,
        refundRequirementsMet: dto.refundRequirementsMet,
        paymentAccount: dto.paymentAccount != null
            ? PaymentAccount.fromDto(dto.paymentAccount!)
            : null,
      );
}
