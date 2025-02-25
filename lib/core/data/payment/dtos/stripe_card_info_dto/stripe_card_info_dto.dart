import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_card_info_dto.freezed.dart';
part 'stripe_card_info_dto.g.dart';

@freezed
class StripeCardInfoDto with _$StripeCardInfoDto {
  factory StripeCardInfoDto({
    String? brand,
    String? last4,
  }) = _StripeCardInfoDto;

  factory StripeCardInfoDto.fromJson(Map<String, dynamic> json) =>
      _$StripeCardInfoDtoFromJson(json);
}
