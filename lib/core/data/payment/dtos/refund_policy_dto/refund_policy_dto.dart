import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_policy_dto.g.dart';
part 'refund_policy_dto.freezed.dart';

@freezed
class RefundPolicyDto with _$RefundPolicyDto {
  factory RefundPolicyDto({
    double? timestamp,
    double? percent,
  }) = _RefundPolicyDto;

  factory RefundPolicyDto.fromJson(Map<String, dynamic> json) =>
      _$RefundPolicyDtoFromJson(json);
}
