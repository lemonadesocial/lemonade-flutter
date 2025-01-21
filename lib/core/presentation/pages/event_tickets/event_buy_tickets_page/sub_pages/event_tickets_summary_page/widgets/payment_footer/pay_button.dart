import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.selectedCurrency,
    required this.selectedPaymentAccount,
    required this.disabled,
    this.pricingInfo,
    this.isFree = false,
  });

  final EventTicketsPricingInfo? pricingInfo;
  final String selectedCurrency;
  final PaymentAccount? selectedPaymentAccount;
  final bool disabled;
  final bool isFree;

  BigInt get _totalCryptoAmount {
    return (pricingInfo?.cryptoTotal ?? BigInt.zero) +
        // add fee if available for EthereumRelay
        (selectedPaymentAccount?.cryptoFee ?? BigInt.zero);
  }

  double get _totalFiatAmount {
    return (pricingInfo?.fiatTotal ?? 0) +
        (selectedPaymentAccount?.fiatFee ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final currencyInfo = PaymentUtils.getCurrencyInfo(
      selectedPaymentAccount,
      currency: selectedCurrency,
    );

    final amountText = PaymentUtils.isCryptoPayment(pricingInfo)
        ? Web3Utils.formatCryptoCurrency(
            _totalCryptoAmount,
            currency: selectedCurrency,
            decimals: currencyInfo?.decimals ?? 2,
            decimalDigits: currencyInfo?.decimals ?? 2,
          )
        : NumberUtils.formatCurrency(
            amount: _totalFiatAmount,
            currency: selectedCurrency,
            attemptedDecimals: currencyInfo?.decimals ?? 2,
          );

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: LinearGradientButton.primaryButton(
        label: isFree
            ? t.event.eventBuyTickets.redeem
            : t.event.eventBuyTickets.payAmount(amount: amountText),
        onTap: () {
          if (disabled) return;
          AutoRouter.of(context).push(
            EventBuyTicketsProcessingRoute(
              selectedPaymentAccount: selectedPaymentAccount,
              selectedCurrency: selectedCurrency,
            ),
          );
        },
      ),
    );
  }
}
