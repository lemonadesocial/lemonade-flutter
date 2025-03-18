import 'package:app/core/data/event/dtos/event_checkin_dto/event_checkin_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_dto.freezed.dart';
part 'event_ticket_dto.g.dart';

@freezed
class EventTicketDto with _$EventTicketDto {
  factory EventTicketDto({
    @JsonKey(name: '_id') String? id,
    bool? accepted,
    @JsonKey(name: 'assigned_email') String? assignedEmail,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    String? event,
    @JsonKey(name: 'invited_by') String? invitedBy,
    @JsonKey(name: 'assigned_to_expanded') UserDto? assignedToExpanded,
    String? type,
    @JsonKey(name: 'type_expanded') EventTicketTypeDto? typeExpanded,
    @JsonKey(name: 'shortid') String? shortId,
    @JsonKey(name: 'acquired_tickets') List<EventTicketDto>? acquiredTickets,
    @JsonKey(name: 'checkin') EventCheckinDto? checkin,
    @JsonKey(name: 'assigned_to_info') UserDto? assignedToInfo,
  }) = _EventTicketDto;

  factory EventTicketDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketDtoFromJson(json);
}

@freezed
class TicketInfoDto with _$TicketInfoDto {
  factory TicketInfoDto({
    double? count,
    @JsonKey(name: 'ticket_type') String? ticketType,
  }) = _TicketInfoDto;

  factory TicketInfoDto.fromJson(Map<String, dynamic> json) =>
      _$TicketInfoDtoFromJson(json);
}
