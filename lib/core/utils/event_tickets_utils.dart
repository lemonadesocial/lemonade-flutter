import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

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
            (price) => price.currency != null
                ? price.network == null || price.network?.isEmpty == true
                : false,
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
            (price) => price.currency != null
                ? price.network?.isNotEmpty == true
                : false,
          ),
        )
        .toList();
  }

  static EventTicketPrice? getTicketPriceByCurrencyAndNetwork({
    PurchasableTicketType? ticketType,
    String? currency,
    String? network,
  }) {
    if (ticketType == null || currency == null) return null;

    return (ticketType.prices ?? []).firstWhereOrNull((element) {
      if (network?.isNotEmpty == true) {
        return element.currency == currency && element.network == network;
      }
      return element.currency == currency;
    });
  }

  static EventCurrency? getEventCurrency({
    required List<EventCurrency> currencies,
    String? currency,
    String? network,
  }) {
    if (currency == null) return null;
    return currencies.firstWhereOrNull(
      (element) {
        if (network?.isNotEmpty == true) {
          return element.currency == currency && element.network == network;
        }
        return element.currency == currency;
      },
    );
  }

  static List<String> getEventSupportedPaymentNetworks({
    required List<EventCurrency> currencies,
  }) {
    List<String> networks = [];
    for (var eventCurrency in currencies) {
      if (eventCurrency.network?.isNotEmpty == true) {
        networks.add(eventCurrency.network!);
      }
    }
    return networks.unique();
  }

  static PaymentAccount? findStripePaymentAccount(
    List<PaymentAccount> paymentAccounts,
  ) {
    return paymentAccounts.firstWhereOrNull((payAcc) {
      return payAcc.provider == PaymentProvider.stripe;
    });
  }

  static PaymentAccount? findEthereumPaymentAccount(
    List<PaymentAccount> paymentAccounts, {
    required String network,
    required String currency,
  }) {
    return paymentAccounts.firstWhereOrNull((payAcc) {
      return payAcc.type == PaymentAccountType.ethereum &&
          (payAcc.accountInfo?.networks?.contains(network) ?? false) &&
          (payAcc.accountInfo?.currencies?.contains(currency) ?? false);
    });
  }

  static String getDisplayedTicketPrice({
    int? decimals,
    EventTicketPrice? price,
  }) {
    if (decimals == null) return t.event.free;

    final formatter = NumberFormat.currency(
      symbol: price?.currency,
      decimalDigits: decimals,
    );
    double? doubleAmount;
    String? erc20DisplayedAmount;
    final isERC20 = price?.network?.isNotEmpty == true;

    if (isERC20) {
      erc20DisplayedAmount = Web3Utils.formatCryptoCurrency(
        BigInt.parse(price?.cost ?? '0'),
        currency: price?.currency ?? '',
        decimals: decimals,
        decimalDigits: decimals,
      );
    } else {
      final parsedAmount = int.parse(price?.cost ?? '0');
      if (parsedAmount == 0) {
        return t.event.free;
      }
      doubleAmount = NumberUtils.getAmountByDecimals(
        BigInt.from(parsedAmount),
        decimals: decimals,
      );
    }
    return isERC20
        ? erc20DisplayedAmount ?? ''
        : formatter.format(doubleAmount);
  }

  static Future<String> getDisplayedTicketPriceAsync({
    required eventId,
    required EventTicketPrice? ticketPrice,
  }) async {
    final currencyListResult =
        await getIt<EventTicketRepository>().getEventCurrencies(
      input: GetEventCurrenciesInput(
        id: eventId,
      ),
    );
    final currencyList = currencyListResult.getOrElse(() => []);
    final currency = currencyList
        .firstWhereOrNull((item) => item.currency == ticketPrice?.currency);
    return getDisplayedTicketPrice(
      price: ticketPrice,
      decimals: currency?.decimals?.toInt(),
    );
  }
}
