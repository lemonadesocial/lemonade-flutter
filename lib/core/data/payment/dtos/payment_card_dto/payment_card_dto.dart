import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_card_dto.freezed.dart';

part 'payment_card_dto.g.dart';

@freezed
class PaymentCardDto with _$PaymentCardDto {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PaymentCardDto({
    required String id,
    String? user,
    String? name,
    String? last4,
    String? brand,
    bool? active,
    DateTime? stamp,
    String? providerId,
    String? provider,
  }) = _PaymentCardDto;

  factory PaymentCardDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardDtoFromJson(json);
}
