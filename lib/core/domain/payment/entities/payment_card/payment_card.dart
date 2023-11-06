import 'package:app/core/data/payment/dtos/payment_card_dto/payment_card_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card.freezed.dart';
part 'payment_card.g.dart';

@freezed
class PaymentCard with _$PaymentCard {
  const factory PaymentCard({
    required String id,
    required String last4,
    String? brand,
    String? providerId,
  }) = _PaymentCard;

  factory PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardFromJson(json);

  factory PaymentCard.fromDto(PaymentCardDto dto) {
    return PaymentCard(
      id: dto.id,
      last4: dto.last4 ?? '',
    );
  }
}
