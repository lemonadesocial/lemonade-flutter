import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:collection/collection.dart';

class EventTicketUtils {
  static List<EventTicket> getNotAssignedTicketOnly(List<EventTicket> tickets) {
    return tickets
        .where(
          (ticket) =>
              ticket.accepted != true &&
              (ticket.assignedTo == null || ticket.assignedEmail == null),
        )
        .toList();
  }

  static Map<String, List<EventTicket>> groupTicketsByTicketType(
    List<EventTicket> tickets,
  ) =>
      groupBy(tickets, (ticket) => ticket.type ?? '');
}
