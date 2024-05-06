import 'package:app/core/data/payment/dtos/refund_policy_dto/refund_policy_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_policy.freezed.dart';
part 'refund_policy.g.dart';

@freezed
class RefundPolicy with _$RefundPolicy {
  const RefundPolicy._();

  factory RefundPolicy({
    double? timestamp,
    double? percent,
  }) = _RefundPolicy;

  factory RefundPolicy.fromDto(RefundPolicyDto dto) => RefundPolicy(
        timestamp: dto.timestamp,
        percent: dto.percent,
      );
  factory RefundPolicy.fromJson(Map<String, dynamic> json) =>
      _$RefundPolicyFromJson(json);
}
