import 'package:app/core/data/payment/dtos/stripe_card_info_dto/stripe_card_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_card_info.freezed.dart';
part 'stripe_card_info.g.dart';

@freezed
class StripeCardInfo with _$StripeCardInfo {
  factory StripeCardInfo({
    String? brand,
    String? last4,
  }) = _StripeCardInfo;

  factory StripeCardInfo.fromDto(StripeCardInfoDto dto) => StripeCardInfo(
        brand: dto.brand,
        last4: dto.last4,
      );

  factory StripeCardInfo.fromJson(Map<String, dynamic> json) =>
      _$StripeCardInfoFromJson(json);
}
