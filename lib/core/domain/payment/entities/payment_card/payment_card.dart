import 'package:app/core/data/payment/dtos/stripe_card_dto/stripe_card_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card.freezed.dart';
part 'payment_card.g.dart';

@freezed
class PaymentCard with _$PaymentCard {
  const factory PaymentCard({
    String? id,
    String? last4,
    String? brand,
    bool? active,
    String? name,
    String? paymentAccount,
    String? providerId,
    DateTime? stamp,
    String? user,
  }) = _PaymentCard;

  factory PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardFromJson(json);

  factory PaymentCard.fromDto(StripeCardDto dto) {
    return PaymentCard(
      id: dto.id,
      last4: dto.last4 ?? '',
      brand: dto.brand,
      active: dto.active,
      name: dto.name,
      paymentAccount: dto.paymentAccount,
      providerId: dto.providerId,
      stamp: dto.stamp,
      user: dto.user,
    );
  }
}
