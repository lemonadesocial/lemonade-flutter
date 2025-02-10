import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/payment/dtos/payment_refund_info_dto/payment_refund_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_my_tickets_response_dto.freezed.dart';
part 'get_my_tickets_response_dto.g.dart';

@freezed
class GetMyTicketsResponseDto with _$GetMyTicketsResponseDto {
  factory GetMyTicketsResponseDto({
    List<EventTicketDto>? tickets,
    List<PaymentRefundInfoDto>? payments,
  }) = _GetMyTicketsResponseDto;

  factory GetMyTicketsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetMyTicketsResponseDtoFromJson(json);
}
