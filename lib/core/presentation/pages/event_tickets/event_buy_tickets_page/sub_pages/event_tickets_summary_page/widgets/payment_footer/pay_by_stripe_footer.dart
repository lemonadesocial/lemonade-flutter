import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/payment_footer/pay_button.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/payment_footer/select_card_button.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayByStripeFooter extends StatelessWidget {
  const PayByStripeFooter({
    super.key,
    this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedPaymentAccount,
    this.onSelectCard,
    this.onCardAdded,
    this.isFree = false,
    this.disabled = false,
  });
  final EventTicketsPricingInfo? pricingInfo;
  final Function(PaymentCard paymentCard)? onSelectCard;
  final Function(PaymentCard paymentCard)? onCardAdded;
  final String selectedCurrency;
  final PaymentAccount? selectedPaymentAccount;
  final bool isFree;
  final bool disabled;

  String get stripePublishableKey {
    return selectedPaymentAccount?.accountInfo?.publishableKey ?? '';
  }

  void _onPressedSelectCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    AutoRouter.of(context).navigate(
      EventTicketsPaymentMethodRoute(
        publishableKey: stripePublishableKey,
        onCardAdded: onCardAdded,
        onSelectCard: onSelectCard,
        buyButton: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              top: Spacing.smMedium,
              left: Spacing.smMedium,
              right: Spacing.smMedium,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.w,
                  color: colorScheme.outline,
                ),
              ),
            ),
            child: PayButton(
              disabled: disabled,
              pricingInfo: pricingInfo,
              selectedCurrency: selectedCurrency,
              selectedPaymentAccount: selectedPaymentAccount,
              isFree: isFree,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.smMedium,
        ),
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(
              width: 2.w,
              color: colorScheme.onPrimary.withOpacity(0.06),
            ),
          ),
        ),
        child: BlocBuilder<SelectPaymentCardCubit, SelectPaymentCardState>(
          builder: (context, state) {
            if (isFree) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PayButton(
                    disabled: disabled,
                    pricingInfo: pricingInfo,
                    selectedCurrency: selectedCurrency,
                    selectedPaymentAccount: selectedPaymentAccount,
                    isFree: isFree,
                  ),
                ],
              );
            }
            return state.when(
              empty: () {
                return SelectCardButton(
                  onPressedSelect: () => _onPressedSelectCard(context),
                );
              },
              cardSelected: (selectedPaymentCard) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SelectCardButton(
                      onPressedSelect: () => _onPressedSelectCard(context),
                      paymentCard: selectedPaymentCard,
                    ),
                    SizedBox(height: Spacing.smMedium),
                    PayButton(
                      disabled: disabled,
                      pricingInfo: pricingInfo,
                      selectedCurrency: selectedCurrency,
                      selectedPaymentAccount: selectedPaymentAccount,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
