import 'package:freezed_annotation/freezed_annotation.dart';

part 'escrow_deposit_info_dto.g.dart';
part 'escrow_deposit_info_dto.freezed.dart';

@freezed
class EscrowDepositInfoDto with _$EscrowDepositInfoDto {
  factory EscrowDepositInfoDto({
    @JsonKey(name: 'payment_account_id') String? paymentAccountId,
    @JsonKey(name: 'minimum_percent') double? minimumPercent,
    @JsonKey(name: 'minimum_amount') double? minimumAmount,
  }) = _EscrowDepositInfoDto;

  factory EscrowDepositInfoDto.fromJson(Map<String, dynamic> json) =>
      _$EscrowDepositInfoDtoFromJson(json);
}
