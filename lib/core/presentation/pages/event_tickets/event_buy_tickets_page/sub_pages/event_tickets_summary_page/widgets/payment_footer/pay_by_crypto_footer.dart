import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/payment_footer/pay_button.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/presentation/widgets/web3/wallet_connect_active_session.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayByCryptoFooter extends StatelessWidget {
  final EventTicketsPricingInfo pricingInfo;
  final String selectedCurrency;
  final String? selectedNetwork;
  final List<PurchasableItem> selectedTickets;
  final bool isFree;
  final bool disabled;

  const PayByCryptoFooter({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
    this.selectedNetwork,
    this.isFree = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return PayByCryptoFooterView(
      pricingInfo: pricingInfo,
      selectedCurrency: selectedCurrency,
      selectedNetwork: selectedNetwork,
      selectedTickets: selectedTickets,
      isFree: isFree,
      disabled: disabled,
    );
  }
}

class PayByCryptoFooterView extends StatefulWidget {
  final EventTicketsPricingInfo pricingInfo;
  final String selectedCurrency;
  final String? selectedNetwork;
  final List<PurchasableItem> selectedTickets;
  final bool isFree;
  final bool disabled;

  const PayByCryptoFooterView({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
    this.selectedNetwork,
    this.isFree = false,
    this.disabled = false,
  });

  @override
  State<PayByCryptoFooterView> createState() => _PayByCryptoFooterViewState();
}

class _PayByCryptoFooterViewState extends State<PayByCryptoFooterView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.smMedium,
          horizontal: Spacing.smMedium,
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
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            if (widget.isFree) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PayButton(
                    disabled: widget.disabled,
                    selectedCurrency: widget.selectedCurrency,
                    selectedNetwork: widget.selectedNetwork,
                    pricingInfo: widget.pricingInfo,
                  ),
                ],
              );
            }

            if (walletState.activeSession == null) {
              return const ConnectWalletButton();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                WalletConnectActiveSessionWidget(
                  title: t.event.eventPayment.payUsing,
                ),
                SizedBox(height: Spacing.smMedium),
                PayButton(
                  disabled: widget.disabled,
                  selectedCurrency: widget.selectedCurrency,
                  selectedNetwork: widget.selectedNetwork,
                  pricingInfo: widget.pricingInfo,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
