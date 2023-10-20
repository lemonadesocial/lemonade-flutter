import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card_entity.freezed.dart';

@freezed
class PaymentCardEntity with _$PaymentCardEntity {
  const factory PaymentCardEntity({
    required String cardHolder,
    required String cardNumber,
  }) = _PaymentCardEntity;
}
