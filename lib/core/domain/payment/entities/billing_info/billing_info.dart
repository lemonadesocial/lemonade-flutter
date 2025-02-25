import 'package:app/core/data/payment/dtos/billing_info_dto/billing_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'billing_info.freezed.dart';
part 'billing_info.g.dart';

@freezed
class BillingInfo with _$BillingInfo {
  BillingInfo._();

  factory BillingInfo({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
  }) = _BillingInfo;

  factory BillingInfo.fromDto(BillingInfoDto dto) => BillingInfo(
        id: dto.id,
        firstName: dto.firstName,
        lastName: dto.lastName,
        email: dto.email,
      );

  factory BillingInfo.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoFromJson(json);
}
