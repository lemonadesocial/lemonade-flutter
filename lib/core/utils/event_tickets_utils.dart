import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/payment_utils.dart';
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

  static bool isTicketAssignedToMe(
    EventTicket ticket, {
    required String userId,
  }) =>
      ticket.assignedTo == userId;

  static bool isTicketNotAssigned(EventTicket ticket) =>
      ticket.accepted != true &&
      (ticket.assignedTo == null && ticket.assignedEmail == null);

  static bool isTicketAccepted(EventTicket ticket) {
    return ticket.accepted == true;
  }

  static bool isTicketPending(EventTicket ticket) =>
      ticket.accepted != true &&
      (ticket.assignedEmail != null || ticket.assignedTo != null);

  static PurchasableTicketType? getTicketTypeById(
    List<PurchasableTicketType> ticketTypes, {
    required String ticketTypeId,
  }) {
    return ticketTypes
        .firstWhere((ticketType) => ticketType.id == ticketTypeId);
  }

  static Map<String, List<EventTicket>> groupTicketsByTicketType(
    List<EventTicket> tickets,
  ) =>
      groupBy(tickets, (ticket) => ticket.type ?? '');

  static List<PurchasableTicketType> getTicketTypesByCurrency({
    required List<PurchasableTicketType> ticketTypes,
    required Currency currency,
  }) {
    return ticketTypes
        .where(
          (element) =>
              (element.prices ?? Map.fromEntries([])).keys.contains(currency),
        )
        .toList();
  }

  static List<PurchasableTicketType> getTicketTypesSupportStripe({
    required List<PurchasableTicketType> ticketTypes,
  }) {
    return ticketTypes
        .where(
          (element) => (element.prices ?? Map.fromEntries([])).keys.any(
                (currency) => !PaymentUtils.isCryptoCurrency(currency),
              ),
        )
        .toList();
  }

  static List<PurchasableTicketType> getTicketTypesSupportCrypto({
    required List<PurchasableTicketType> ticketTypes,
  }) {
    return ticketTypes
        .where(
          (element) => (element.prices ?? Map.fromEntries([])).keys.any(
                (currency) => PaymentUtils.isCryptoCurrency(currency),
              ),
        )
        .toList();
  }

  static getSupportedCurrencies({
    required List<PurchasableTicketType> ticketTypes,
  }) {
    List<Currency> currencies = [];
    for (var element in ticketTypes) {
      currencies.addAll((element.prices ?? Map.fromEntries([])).keys);
    }
    return currencies.unique();
  }
}
