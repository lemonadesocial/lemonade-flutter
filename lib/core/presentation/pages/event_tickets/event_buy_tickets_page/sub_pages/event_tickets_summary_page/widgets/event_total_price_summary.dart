import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EventTotalPriceSummary extends StatelessWidget {
  const EventTotalPriceSummary({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedPaymentAccount,
  });

  final EventTicketsPricingInfo pricingInfo;
  final String selectedCurrency;
  final PaymentAccount? selectedPaymentAccount;

  BigInt get _totalCryptoAmount {
    return (pricingInfo.cryptoTotal ?? BigInt.zero) +
        // add fee if available for EthereumRelay
        (selectedPaymentAccount?.cryptoFee ?? BigInt.zero);
  }

  double get _totalFiatAmount {
    return (pricingInfo.fiatTotal ?? 0) +
        (selectedPaymentAccount?.fiatFee ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final currencyInfo = PaymentUtils.getCurrencyInfo(
      selectedPaymentAccount,
      currency: selectedCurrency,
    );
    final isCryptoPayment = PaymentUtils.isCryptoPayment(pricingInfo);
    false;

    return Column(
      children: [
        if (selectedPaymentAccount?.fee?.isNotEmpty == true) ...[
          SummaryRow(
            label: t.event.eventOrder.fee,
            value: Web3Utils.formatCryptoCurrency(
              selectedPaymentAccount?.cryptoFee ?? BigInt.zero,
              currency: selectedCurrency,
              decimals: currencyInfo?.decimals ?? 0,
            ),
            textColor: colorScheme.onSecondary,
          ),
        ],
        SizedBox(height: Spacing.xSmall),
        SummaryRow(
          label: t.event.eventOrder.grandTotal,
          value: isCryptoPayment
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
