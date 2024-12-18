import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/domain/event/entities/event_checkin.dart';
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
    List<EventTicket>? acquiredTickets,
    EventCheckin? checkin,
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
        acquiredTickets: dto.acquiredTickets != null
            ? List.from(dto.acquiredTickets ?? [])
                .map((e) => EventTicket.fromDto(e))
                .toList()
            : [],
        checkin:
            dto.checkin != null ? EventCheckin.fromDto(dto.checkin!) : null,
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
