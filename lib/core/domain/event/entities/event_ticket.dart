import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket.freezed.dart';

class EventTicket {
  final String? id;
  final bool? accepted;
  final String? assignedEmail;
  final String? assignedTo;
  final String? event;
  final String? invitedBy;
  final String? type;
  final User? assignedToExpanded;

  const EventTicket({
    this.id,
    this.accepted,
    this.assignedEmail,
    this.assignedTo,
    this.event,
    this.invitedBy,
    this.type,
    this.assignedToExpanded,
  });

  factory EventTicket.fromDto(EventTicketDto dto) => EventTicket(
        id: dto.id,
        accepted: dto.accepted,
        assignedEmail: dto.assignedEmail,
        assignedTo: dto.assignedTo,
        event: dto.event,
        invitedBy: dto.invitedBy,
        type: dto.type,
        assignedToExpanded: dto.assignedToExpanded != null
            ? User.fromDto(dto.assignedToExpanded!)
            : null,
      );
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
