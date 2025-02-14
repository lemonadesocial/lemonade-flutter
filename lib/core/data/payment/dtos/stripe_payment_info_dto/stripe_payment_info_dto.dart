import 'package:app/core/data/payment/dtos/stripe_card_info_dto/stripe_card_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_payment_info_dto.freezed.dart';
part 'stripe_payment_info_dto.g.dart';

@freezed
class StripePaymentInfoDto with _$StripePaymentInfoDto {
  factory StripePaymentInfoDto({
    @JsonKey(name: 'payment_intent') String? paymentIntent,
    StripeCardInfoDto? card,
  }) = _StripePaymentInfoDto;

  factory StripePaymentInfoDto.fromJson(Map<String, dynamic> json) =>
      _$StripePaymentInfoDtoFromJson(json);
}
