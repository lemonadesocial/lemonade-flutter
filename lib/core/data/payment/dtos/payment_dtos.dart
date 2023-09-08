import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_dtos.freezed.dart';
part 'payment_dtos.g.dart';

@freezed
class PaymentDto with _$PaymentDto {
  const factory PaymentDto({
    @JsonKey(name: '_id') String? id,
    double? amount,
    Currency? currency,
  }) = _PaymentDto;

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);
}
