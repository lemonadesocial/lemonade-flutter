import 'package:app/core/data/payment/dtos/billing_info_dto/billing_info_dto.dart';
import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
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
    PaymentState? state,
    dynamic stamps,
    @JsonKey(name: 'failure_reason') String? failureReason,
    String? currency,
    @JsonKey(name: 'billing_info') BillingInfoDto? billingInfo,
    String? amount,
    @JsonKey(name: 'account_expanded') PaymentAccountDto? accountExpanded,
    String? account,
  }) = _PaymentDto;

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);
}

@freezed
class PaymentBaseDto with _$PaymentBaseDto {
  const factory PaymentBaseDto({
    @JsonKey(name: '_id') String? id,
    String? user,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
    @JsonKey(name: 'transfer_metadata') Map<String, dynamic>? transferMetadata,
    PaymentState? state,
    dynamic stamps,
    @JsonKey(name: 'failure_reason') String? failureReason,
    String? currency,
    @JsonKey(name: 'billing_info') BillingInfoDto? billingInfo,
    String? amount,
    String? account,
  }) = _PaymentBaseDto;

  factory PaymentBaseDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentBaseDtoFromJson(json);
}
