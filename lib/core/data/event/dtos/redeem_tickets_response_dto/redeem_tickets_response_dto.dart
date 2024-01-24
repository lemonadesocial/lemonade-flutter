import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'redeem_tickets_response_dto.freezed.dart';
part 'redeem_tickets_response_dto.g.dart';

@freezed
class RedeemTicketsResponseDto with _$RedeemTicketsResponseDto {
  factory RedeemTicketsResponseDto({
    @JsonKey(name: 'event_join_request') EventJoinRequestDto? eventJoinRequest,
    List<EventTicketDto>? tickets,
  }) = _RedeemTicketsResponseDto;

  factory RedeemTicketsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RedeemTicketsResponseDtoFromJson(json);
}
