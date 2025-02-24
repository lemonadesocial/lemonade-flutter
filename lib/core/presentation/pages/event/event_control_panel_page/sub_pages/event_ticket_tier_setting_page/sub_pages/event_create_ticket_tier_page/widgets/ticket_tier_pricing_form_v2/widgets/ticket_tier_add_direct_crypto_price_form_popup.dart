import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:flutter/material.dart';

class TicketTierAddDirectCryptoFormPopup extends StatelessWidget {
  // Relay type
  final List<PaymentAccount> eventLevelDirectCryptoPaymentAccounts;
  const TicketTierAddDirectCryptoFormPopup({
    super.key,
    required this.eventLevelDirectCryptoPaymentAccounts,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap with ModifyTicketPriceV2Bloc
    return _View(
      eventLevelDirectCryptoPaymentAccounts:
          eventLevelDirectCryptoPaymentAccounts,
    );
  }
}

class _View extends StatelessWidget {
  const _View({
    required this.eventLevelDirectCryptoPaymentAccounts,
  });

  final List<PaymentAccount> eventLevelDirectCryptoPaymentAccounts;

  // void _onAmountChanged(String amount) {
  //   /**
  //    *
  //    */
  // }

  // void _onCurrencyChanged(String currency) {
  //   /**
  //    *
  //    */
  // }

  // void _onPaymentAccountChanged(PaymentAccount paymentAccount) {
  //   /**

  //    */
  // }

  // void _onSave() {
  //   /*
  //     ticketPriceInput = TicketPriceInput(
  //       amount: state.amount,
  //       currency: state.currency,
  //       paymentAccounts: [state.selectedPaymentAccount],
  //     );
  //    Navigator.of(context).pop(ticketPriceInput)
  //    */
  // }

  @override
  Widget build(BuildContext context) {
    /*
     InputField
     SelectCurrencyDropdown
     PaymentAccountList
     SaveButton
     */
    return const Placeholder();
  }
}
