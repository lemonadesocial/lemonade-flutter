import 'package:app/core/data/payment/dtos/crypto_payment_info_dto/crypto_payment_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_payment_info.freezed.dart';
part 'crypto_payment_info.g.dart';

@freezed
class CryptoPaymentInfo with _$CryptoPaymentInfo {
  factory CryptoPaymentInfo({
    String? network,
    String? txHash,
  }) = _CryptoPaymentInfo;

  factory CryptoPaymentInfo.fromDto(CryptoPaymentInfoDto dto) =>
      CryptoPaymentInfo(
        network: dto.network,
        txHash: dto.txHash,
      );

  factory CryptoPaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$CryptoPaymentInfoFromJson(json);
}
