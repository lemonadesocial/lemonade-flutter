import 'package:app/core/data/event/dtos/ticket_dto/ticket_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
class Ticket with _$Ticket {
  factory Ticket({
    required String id,
    required String shortid,
    required DateTime createdAt,
    required String event,
    required String type,
    bool? accepted,
    String? acquiredBy,
    String? cancelledBy,
    String? acquiredByEmail,
    String? assignedEmail,
    String? assignedTo,
    String? invitedBy,
    String? paymentId,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? assignedToInfo,
    User? assignedToExpanded,
    Event? eventExpanded,
    EventTicketType? typeExpanded,
    List<Ticket>? acquiredTickets,
  }) = _Ticket;

  factory Ticket.fromDto(TicketDto dto) => Ticket(
        id: dto.id,
        shortid: dto.shortid,
        createdAt: dto.createdAt,
        event: dto.event,
        type: dto.type,
        accepted: dto.accepted,
        acquiredBy: dto.acquiredBy,
        cancelledBy: dto.cancelledBy,
        acquiredByEmail: dto.acquiredByEmail,
        assignedEmail: dto.assignedEmail,
        assignedTo: dto.assignedTo,
        invitedBy: dto.invitedBy,
        paymentId: dto.paymentId,
        metadata: dto.metadata,
        assignedToInfo: dto.assignedToInfo,
        assignedToExpanded: dto.assignedToExpanded != null
            ? User.fromDto(dto.assignedToExpanded!)
            : null,
        eventExpanded: dto.eventExpanded != null
            ? Event.fromDto(dto.eventExpanded!)
            : null,
        typeExpanded: dto.typeExpanded != null
            ? EventTicketType.fromDto(dto.typeExpanded!)
            : null,
        acquiredTickets:
            dto.acquiredTickets?.map((e) => Ticket.fromDto(e)).toList(),
      );

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
