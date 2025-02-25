import 'package:app/core/data/payment/dtos/stripe_payment_info_dto/stripe_payment_info_dto.dart';
import 'package:app/core/domain/payment/entities/stripe_card_info/stripe_card_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_payment_info.freezed.dart';
part 'stripe_payment_info.g.dart';

@freezed
class StripePaymentInfo with _$StripePaymentInfo {
  factory StripePaymentInfo({
    String? paymentIntent,
    StripeCardInfo? card,
  }) = _StripePaymentInfo;

  factory StripePaymentInfo.fromDto(StripePaymentInfoDto dto) =>
      StripePaymentInfo(
        paymentIntent: dto.paymentIntent,
        card: dto.card != null ? StripeCardInfo.fromDto(dto.card!) : null,
      );

  factory StripePaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$StripePaymentInfoFromJson(json);
}
