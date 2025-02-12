import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/data/payment/dtos/refund_policy_dto/refund_policy_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_refund_info_dto.freezed.dart';
part 'payment_refund_info_dto.g.dart';

@freezed
class PaymentRefundInfoDto with _$PaymentRefundInfoDto {
  factory PaymentRefundInfoDto({
    @JsonKey(name: '_id') String? id,
    String? amount,
    String? currency,
    Enum$NewPaymentState? state,
    @JsonKey(name: 'attempting_refund') bool? attemptingRefund,
    @JsonKey(name: 'refund_policy') RefundPolicyDto? refundPolicy,
    @JsonKey(name: 'refund_requirements_met') bool? refundRequirementsMet,
    @JsonKey(name: 'payment_account') PaymentAccountDto? paymentAccount,
  }) = _PaymentRefundInfoDto;

  factory PaymentRefundInfoDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentRefundInfoDtoFromJson(json);
}
