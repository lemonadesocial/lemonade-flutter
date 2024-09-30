import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class EventOrderSummary extends StatelessWidget {
  const EventOrderSummary({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedNetwork,
  });

  final EventTicketsPricingInfo pricingInfo;
  final String? selectedNetwork;
  final String selectedCurrency;

  BigInt get _totalCryptoAmount {
    return (pricingInfo.cryptoTotal ?? BigInt.zero) +
        // add fee if available for EthereumRelay
        (pricingInfo.paymentAccounts?.firstOrNull?.cryptoFee ?? BigInt.zero);
  }

  double get _totalFiatAmount {
    return (pricingInfo.fiatTotal ?? 0) +
        (pricingInfo.paymentAccounts?.firstOrNull?.fiatFee ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isCryptoCurrency = selectedNetwork?.isNotEmpty == true;
    final currencyInfo =
        PaymentUtils.getCurrencyInfo(pricingInfo, currency: selectedCurrency);

    return Column(
      children: [
        if (pricingInfo.paymentAccounts?.first.fee?.isNotEmpty == true) ...[
          SummaryRow(
            label: t.event.eventOrder.fee,
            value: Web3Utils.formatCryptoCurrency(
              pricingInfo.paymentAccounts?.firstOrNull?.cryptoFee ??
                  BigInt.zero,
              currency: selectedCurrency,
              decimals: currencyInfo?.decimals ?? 0,
            ),
            textColor: colorScheme.onSecondary,
          ),
        ],
        SizedBox(height: Spacing.xSmall),
        SummaryRow(
          label: t.event.eventOrder.grandTotal,
          value: isCryptoCurrency
              ? Web3Utils.formatCryptoCurrency(
                  _totalCryptoAmount,
                  currency: selectedCurrency,
                  decimals: currencyInfo?.decimals ?? 0,
                )
              : NumberUtils.formatCurrency(
                  amount: _totalFiatAmount,
                  currency: selectedCurrency,
                  attemptedDecimals: currencyInfo?.decimals ?? 2,
                ),
          textStyle: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.textColor,
    this.textStyle,
  });

  final String label;
  final String value;
  final Color? textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final customTextStyle = textStyle ??
        Typo.medium.copyWith(
          color: textColor ?? colorScheme.onSecondary,
        );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: customTextStyle,
        ),
        const Spacer(),
        Text(
          value,
          style: customTextStyle,
        ),
      ],
    );
  }
}
