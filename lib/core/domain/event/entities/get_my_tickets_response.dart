import 'package:app/core/data/event/dtos/get_my_tickets_response_dto/get_my_tickets_response_dto.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/payment/entities/payment_refund_info/payment_refund_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_my_tickets_response.freezed.dart';

@freezed
class GetMyTicketsResponse with _$GetMyTicketsResponse {
  GetMyTicketsResponse._();

  factory GetMyTicketsResponse({
    List<EventTicket>? tickets,
    List<PaymentRefundInfo>? payments,
  }) = _GetMyTicketsResponse;

  factory GetMyTicketsResponse.fromDto(GetMyTicketsResponseDto dto) =>
      GetMyTicketsResponse(
        tickets: dto.tickets?.map((t) => EventTicket.fromDto(t)).toList(),
        payments: (dto.payments ?? [])
            .map((p) => PaymentRefundInfo.fromDto(p))
            .toList(),
      );
}
