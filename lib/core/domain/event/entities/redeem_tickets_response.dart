import 'package:app/core/data/event/dtos/redeem_tickets_response_dto/redeem_tickets_response_dto.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'redeem_tickets_response.freezed.dart';

@freezed
class RedeemTicketsResponse with _$RedeemTicketsResponse {
  RedeemTicketsResponse._();

  factory RedeemTicketsResponse({
    EventJoinRequest? eventJoinRequest,
    List<EventTicket>? tickets,
  }) = _RedeemTicketsResponse;

  factory RedeemTicketsResponse.fromDto(RedeemTicketsResponseDto dto) =>
      RedeemTicketsResponse(
        eventJoinRequest: dto.eventJoinRequest != null
            ? EventJoinRequest.fromDto(dto.eventJoinRequest!)
            : null,
        tickets: List.from(
          dto.tickets ?? [],
        )
            .map(
              (item) => EventTicket.fromDto(item),
            )
            .toList(),
      );
}
