import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_payment_info_dto.freezed.dart';
part 'crypto_payment_info_dto.g.dart';

@freezed
class CryptoPaymentInfoDto with _$CryptoPaymentInfoDto {
  factory CryptoPaymentInfoDto({
    String? network,
    @JsonKey(name: 'tx_hash') String? txHash,
  }) = _CryptoPaymentInfoDto;

  factory CryptoPaymentInfoDto.fromJson(Map<String, dynamic> json) =>
      _$CryptoPaymentInfoDtoFromJson(json);
}
