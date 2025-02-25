import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_event_payments_response_dto.freezed.dart';
part 'list_event_payments_response_dto.g.dart';

@freezed
class ListEventPaymentsResponseDto with _$ListEventPaymentsResponseDto {
  factory ListEventPaymentsResponseDto({
    required int total,
    required List<PaymentDto> records,
  }) = _ListEventPaymentsResponseDto;

  factory ListEventPaymentsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ListEventPaymentsResponseDtoFromJson(json);
}
