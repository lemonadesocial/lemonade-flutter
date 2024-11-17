import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket.freezed.dart';
part 'event_ticket.g.dart';

@freezed
class EventTicket with _$EventTicket {
  const EventTicket._();

  @JsonSerializable(explicitToJson: true)
  factory EventTicket({
    String? id,
    bool? accepted,
    String? assignedEmail,
    String? assignedTo,
    String? event,
    String? invitedBy,
    String? type,
    EventTicketType? typeExpanded,
    User? assignedToExpanded,
    String? shortId,
  }) = _EventTicket;

  factory EventTicket.fromDto(EventTicketDto dto) => EventTicket(
        id: dto.id,
        accepted: dto.accepted,
        assignedEmail: dto.assignedEmail,
        assignedTo: dto.assignedTo,
        event: dto.event,
        invitedBy: dto.invitedBy,
        type: dto.type,
        typeExpanded: dto.typeExpanded != null
            ? EventTicketType.fromDto(dto.typeExpanded!)
            : null,
        assignedToExpanded: dto.assignedToExpanded != null
            ? User.fromDto(dto.assignedToExpanded!)
            : null,
        shortId: dto.shortId,
      );

  factory EventTicket.fromJson(Map<String, dynamic> json) =>
      _$EventTicketFromJson(json);
}

@freezed
class TicketInfo with _$TicketInfo {
  factory TicketInfo({
    double? count,
    String? ticketType,
  }) = _TicketInfo;

  factory TicketInfo.fromDto(TicketInfoDto dto) => TicketInfo(
        count: dto.count,
        ticketType: dto.ticketType,
      );
}
