import 'package:freezed_annotation/freezed_annotation.dart';

part 'billing_info_dto.freezed.dart';
part 'billing_info_dto.g.dart';

@freezed
class BillingInfoDto with _$BillingInfoDto {
  factory BillingInfoDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'firstname') String? firstName,
    @JsonKey(name: 'lastname') String? lastName,
    String? email,
  }) = _BillingInfoDto;

  factory BillingInfoDto.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoDtoFromJson(json);
}
