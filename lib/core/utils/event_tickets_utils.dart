import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
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

  static List<PurchasableTicketType> getTicketTypesSupportStripe({
    required List<PurchasableTicketType> ticketTypes,
  }) {
    return ticketTypes
        .where(
          (element) => (element.prices ?? []).any(
            (price) => price.currency != null ? price.network == null : false,
          ),
        )
        .toList();
  }

  static List<PurchasableTicketType> getTicketTypesSupportCrypto({
    required List<PurchasableTicketType> ticketTypes,
  }) {
    return ticketTypes
        .where(
          (element) => (element.prices ?? []).any(
            (price) => price.currency != null ? price.network != null : false,
          ),
        )
        .toList();
  }

  static EventTicketPrice? getTicketPriceByCurrencyAndNetwork({
    PurchasableTicketType? ticketType,
    Currency? currency,
    SupportedPaymentNetwork? network,
  }) {
    if (ticketType == null || currency == null) return null;

    return (ticketType.prices ?? []).firstWhereOrNull(
      (element) => element.currency == currency && element.network == network,
    );
  }

  static EventCurrency? getEventCurrency({
    required List<EventCurrency> currencies,
    Currency? currency,
    SupportedPaymentNetwork? network,
  }) {
    if (currency == null) return null;
    return currencies.firstWhereOrNull(
      (element) => element.currency == currency && element.network == network,
    );
  }

  static List<SupportedPaymentNetwork> getEventSupportedPaymentNetworks({
    required List<EventCurrency> currencies,
  }) {
    List<SupportedPaymentNetwork> networks = [];
    for (var eventCurrency in currencies) {
      if (eventCurrency.network != null) {
        networks.add(eventCurrency.network!);
      }
    }
    return networks.unique();
  }
}
