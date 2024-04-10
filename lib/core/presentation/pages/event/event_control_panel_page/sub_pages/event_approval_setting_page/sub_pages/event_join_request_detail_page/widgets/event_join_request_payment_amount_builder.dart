import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix/matrix.dart';

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
    final decimals = eventJoinRequest
            .paymentExpanded?.accountExpanded?.accountInfo?.currencyMap
            ?.tryGet<CurrencyInfo>(currency ?? '')
            ?.decimals
            ?.toInt() ??
        18;
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
  }
}
