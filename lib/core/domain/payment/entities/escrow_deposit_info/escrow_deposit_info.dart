import 'package:app/core/data/payment/dtos/escrow_deposit_info_dto/escrow_deposit_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'escrow_deposit_info.freezed.dart';

@freezed
class EscrowDepositInfo with _$EscrowDepositInfo {
  const EscrowDepositInfo._();

  factory EscrowDepositInfo({
    double? minimumPercent,
    double? minimumAmount,
  }) = _EscrowDepositInfo;

  factory EscrowDepositInfo.fromDto(EscrowDepositInfoDto dto) =>
      EscrowDepositInfo(
        minimumPercent: dto.minimumPercent,
        minimumAmount: dto.minimumAmount,
      );
}
