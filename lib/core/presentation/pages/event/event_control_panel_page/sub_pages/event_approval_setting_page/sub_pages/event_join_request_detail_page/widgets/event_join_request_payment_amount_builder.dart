import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventJoinRequestPaymentAmountsBuilder extends StatelessWidget {
  final String eventId;
  final EventJoinRequest eventJoinRequest;
  final Widget Function({
    required String formattedDueAmount,
    required String formattedDepositAmount,
    required String formattedTotalAmount,
  }) builder;
  const EventJoinRequestPaymentAmountsBuilder({
    super.key,
    required this.eventId,
    required this.eventJoinRequest,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<EventTicketRepository>().getEventCurrencies(
        input: GetEventCurrenciesInput(id: eventId),
      ),
      builder: (context, snapshot) {
        final paymentAccountType =
            eventJoinRequest.paymentExpanded?.accountExpanded?.type;
        final isCrypto = paymentAccountType == PaymentAccountType.ethereum ||
            paymentAccountType == PaymentAccountType.ethereumEscrow;
        final dueAmount =
            BigInt.parse(eventJoinRequest.paymentExpanded?.dueAmount ?? '0');
        final totalAmount =
            BigInt.parse(eventJoinRequest.paymentExpanded?.amount ?? '0');
        final depositAmount = totalAmount - dueAmount;
        final currency = eventJoinRequest.paymentExpanded?.currency;
        final currencies = snapshot.data?.getOrElse(() => []) ?? [];
        final decimals = (EventTicketUtils.getEventCurrency(
                  currencies: currencies,
                  currency: currency,
                )?.decimals ??
                18)
            .toInt();
        final formattedDepositAmount = depositAmount == BigInt.zero
            ? ''
            : Web3Utils.formatCryptoCurrency(
                depositAmount,
                currency: currency ?? '',
                decimals: decimals,
              );
        final formattedDueAmount = dueAmount == BigInt.zero
            ? ''
            : Web3Utils.formatCryptoCurrency(
                dueAmount,
                currency: currency ?? '',
                decimals: decimals,
              );

        String formattedTotalAmount = '';

        if (isCrypto) {
          formattedTotalAmount = Web3Utils.formatCryptoCurrency(
            totalAmount,
            currency: currency ?? '',
            decimals: decimals,
          );
        } else {
          if (totalAmount == BigInt.zero) {
            formattedTotalAmount = '';
          } else {
            final formatter = NumberFormat.currency(
              symbol: currency,
              decimalDigits: decimals,
            );
            formattedTotalAmount = formatter.format(
              NumberUtils.getAmountByDecimals(
                totalAmount,
                decimals: decimals,
              ),
            );
          }
        }

        return builder(
          formattedDueAmount: formattedDueAmount,
          formattedDepositAmount: formattedDepositAmount,
          formattedTotalAmount: formattedTotalAmount,
        );
      },
    );
  }
}
