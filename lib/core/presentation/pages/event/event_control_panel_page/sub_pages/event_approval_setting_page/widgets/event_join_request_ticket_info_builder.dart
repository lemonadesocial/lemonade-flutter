import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class EventJoinRequestTicketInfoBuilder extends StatelessWidget {
  final Widget Function({
    required int totalTicketCount,
    required String displayedTotalCost,
    required bool isLoading,
  }) builder;
  final EventJoinRequest eventJoinRequest;

  const EventJoinRequestTicketInfoBuilder({
    super.key,
    required this.builder,
    required this.eventJoinRequest,
  });

  int get totalTicketCount => (eventJoinRequest.ticketInfo ?? [])
      .map((item) => item.count ?? 0)
      .reduce((a, b) => a + b)
      .toInt();

  String getDisplayTotalCost(List<EventCurrency> currencies) {
    final isCrypto = eventJoinRequest.paymentExpanded?.accountExpanded?.type !=
            PaymentAccountType.digital &&
        eventJoinRequest.paymentExpanded?.accountExpanded?.type != null;
    final targetCurrency = currencies.firstWhereOrNull(
      (item) => item.currency == eventJoinRequest.paymentExpanded?.currency,
    );

    if (currencies.isEmpty || targetCurrency == null) return t.event.free;

    final decimals = targetCurrency.decimals?.toInt() ?? 1;
    final amount = eventJoinRequest.paymentExpanded?.amount;

    final formatter = NumberFormat.currency(
      symbol: targetCurrency.currency,
      decimalDigits: decimals,
    );

    double? doubleAmount;
    String? erc20DisplayedAmount;

    if (isCrypto) {
      erc20DisplayedAmount = Web3Utils.removeTrailingZeros(
        Web3Utils.formatCryptoCurrency(
          BigInt.parse(amount ?? '0'),
          currency: targetCurrency.currency ?? '',
          decimals: decimals,
          decimalDigits: decimals,
        ),
      );
    } else {
      final parsedAmount = int.parse(amount ?? '0');
      if (parsedAmount == 0) {
        return t.event.free;
      }
      doubleAmount = NumberUtils.getAmountByDecimals(
        BigInt.from(parsedAmount),
        decimals: decimals,
      );
    }
    return isCrypto
        ? erc20DisplayedAmount ?? ''
        : formatter.format(doubleAmount);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<EventTicketRepository>().getEventCurrencies(
        input: GetEventCurrenciesInput(
          id: eventJoinRequest.eventExpanded?.id ?? '',
        ),
      ),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        List<EventCurrency> currencies =
            snapshot.data?.fold((l) => [], (r) => r) ?? [];

        return builder(
          totalTicketCount: totalTicketCount,
          displayedTotalCost: isLoading ? '' : getDisplayTotalCost(currencies),
          isLoading: isLoading,
        );
      },
    );
  }
}
