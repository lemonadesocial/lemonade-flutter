import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_card_dto.freezed.dart';

part 'stripe_card_dto.g.dart';

@freezed
class StripeCardDto with _$StripeCardDto {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory StripeCardDto({
    @JsonKey(name: '_id') String? id,
    bool? active,
    PaymentCardBrand? brand,
    String? last4,
    String? name,
    @JsonKey(name: 'payment_account') String? paymentAccount,
    @JsonKey(name: 'provider_id') String? providerId,
    DateTime? stamp,
    String? user,
  }) = _StripeCardDto;

  factory StripeCardDto.fromJson(Map<String, dynamic> json) =>
      _$StripeCardDtoFromJson(json);
}
