import 'package:app/core/data/payment/dtos/list_event_payments_response_dto/list_event_payments_response_dto.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_event_payments_response.freezed.dart';
part 'list_event_payments_response.g.dart';

@freezed
class ListEventPaymentsResponse with _$ListEventPaymentsResponse {
  factory ListEventPaymentsResponse({
    required int total,
    required List<Payment> records,
  }) = _ListEventPaymentsResponse;

  factory ListEventPaymentsResponse.fromDto(ListEventPaymentsResponseDto dto) =>
      ListEventPaymentsResponse(
        total: dto.total,
        records: dto.records.map((e) => Payment.fromDto(e)).toList(),
      );

  factory ListEventPaymentsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListEventPaymentsResponseFromJson(json);
}
