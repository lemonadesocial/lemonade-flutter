import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card_entity.freezed.dart';

part 'payment_card_entity.g.dart';

@freezed
class PaymentCardEntity with _$PaymentCardEntity {
  const factory PaymentCardEntity({
    required String cardHolder,
    required String cardNumber,
  }) = _PaymentCardEntity;

  factory PaymentCardEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardEntityFromJson(json);
}
