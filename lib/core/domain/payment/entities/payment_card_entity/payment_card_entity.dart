import 'package:app/core/data/payment/dtos/payment_card_dto/payment_card_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card_entity.freezed.dart';

part 'payment_card_entity.g.dart';

@freezed
class PaymentCardEntity with _$PaymentCardEntity {
  const factory PaymentCardEntity({
    required String id,
    required String last4,
    String? brand,
    String? providerId,
  }) = _PaymentCardEntity;

  factory PaymentCardEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardEntityFromJson(json);

  factory PaymentCardEntity.fromDto(PaymentCardDto dto) {
    return PaymentCardEntity(
      id: dto.id,
      last4: dto.last4 ?? '',
    );
  }
}
