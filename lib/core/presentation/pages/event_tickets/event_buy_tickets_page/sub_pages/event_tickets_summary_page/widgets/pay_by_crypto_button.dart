import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/select_payment_network_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/wallet_connect/wallet_connect_popup/wallet_connect_popup.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class PayByCryptoButton extends StatelessWidget {
  final EventTicketsPricingInfo pricingInfo;
  final Currency selectedCurrency;
  final List<PurchasableItem> selectedTickets;

  const PayByCryptoButton({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletBloc()
        ..add(
          const WalletEvent.initWalletConnect(),
        ),
      child: PayByCryptoButtonView(
        pricingInfo: pricingInfo,
        selectedCurrency: selectedCurrency,
        selectedTickets: selectedTickets,
      ),
    );
  }
}

class PayByCryptoButtonView extends StatefulWidget {
  final EventTicketsPricingInfo pricingInfo;
  final Currency selectedCurrency;
  final List<PurchasableItem> selectedTickets;

  const PayByCryptoButtonView({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
  });

  @override
  State<PayByCryptoButtonView> createState() => _PayByCryptoButtonViewState();
}

class _PayByCryptoButtonViewState extends State<PayByCryptoButtonView> {
  void showSelectWalletPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (newContext) => WalletConnectPopup(
        onSelect: (walletApp) {
          Navigator.of(newContext).pop();
          context.read<WalletBloc>().add(
                WalletEventConnectWallet(
                  walletApp: walletApp,
                ),
              );
        },
      ),
    );
  }

  clickSelectNetwork() {
    final networks =
        widget.pricingInfo.paymentAccounts?.first.accountInfo?.networks ?? [];
    SelectPaymentNetworkBottomSheet(
      networks: networks,
      onSelectNetwork: (network) {
        context.read<BuyTicketsWithCryptoBloc>().add(
              BuyTicketsWithCryptoEvent.selectNetwork(
                network: network,
              ),
            );
      },
    ).showAsBottomSheet(
      context,
      heightFactor: 0.5,
    );
  }

  clickInitPaymentAndSigned({
    required Event event,
    required String userWalletAddress,
  }) {
    context.read<BuyTicketsWithCryptoBloc>().add(
          BuyTicketsWithCryptoEvent.initAndSignPayment(
            userWalletAddress: userWalletAddress,
            input: BuyTicketsInput(
              eventId: event.id ?? '',
              accountId: widget.pricingInfo.paymentAccounts?.first.id ?? '',
              currency: widget.selectedCurrency,
              items: widget.selectedTickets,
              total: widget.pricingInfo.total ?? '0',
            ),
          ),
        );
  }

  clickMakeTransaction({
    required String userWalletAddress,
  }) {
    final currencyInfo = PaymentUtils.getCurrencyInfo(
      widget.pricingInfo,
      currency: widget.selectedCurrency,
    );

    if (currencyInfo == null) return;

    context.read<BuyTicketsWithCryptoBloc>().add(
          BuyTicketsWithCryptoEvent.makeTransaction(
            from: userWalletAddress,
            amount: widget.pricingInfo.cryptoTotal ?? BigInt.zero,
            to: widget
                    .pricingInfo.paymentAccounts?.first.accountInfo?.address ??
                '',
            currencyInfo: currencyInfo,
          ),
        );
  }

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
            if (walletState.activeSession == null) {
              return LinearGradientButton(
                height: Sizing.large,
                radius: BorderRadius.circular(LemonRadius.small * 2),
                mode: GradientButtonMode.lavenderMode,
                label: t.event.eventCryptoPayment.connectWallet,
                onTap: () => showSelectWalletPopup(context),
              );
            }

            final sessionAccount = walletState
                .activeSession!.namespaces.entries.first.value.accounts.first;
            final userWalletAddress = NamespaceUtils.getAccount(sessionAccount);

            final event = context.read<EventProviderBloc>().event;
            return BlocBuilder<BuyTicketsWithCryptoBloc,
                BuyTicketsWithCryptoState>(
              builder: (context, state) {
                final selectedNetwork = state.data.selectedNetwork;
                String buttonTitle = '';
                Function()? onPress;

                if (state is BuyTicketsWithCryptoStateLoading) {
                  buttonTitle = t.common.processing;
                }

                if (state is BuyTicketsWithCryptoStateDone) {
                  buttonTitle = t.event.eventCryptoPayment.waitForConfirmation;
                }

                if (state is BuyTicketsWithCryptoStateIdle) {
                  buttonTitle = t.event.eventCryptoPayment.selectNetwork;
                  onPress = () => clickSelectNetwork();
                }

                if (state is BuyTicketsWithCryptoStateNetworkSelected) {
                  buttonTitle =
                      buttonTitle = t.event.eventCryptoPayment.signPayment;
                  onPress = () => clickInitPaymentAndSigned(
                        event: event,
                        userWalletAddress: userWalletAddress,
                      );
                }

                if (state is BuyTicketsWithCryptoStateSigned) {
                  buttonTitle = buttonTitle = t.event.eventCryptoPayment.pay;
                  onPress = () => clickMakeTransaction(
                        userWalletAddress: userWalletAddress,
                      );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedNetwork != null)
                      Text(
                        "Network: ${Web3Utils.getNetworkMetadataById(selectedNetwork.value).displayName}",
                      ),
                    SizedBox(
                      height: Spacing.smMedium,
                    ),
                    LinearGradientButton(
                      onTap: () {
                        onPress?.call();
                      },
                      height: Sizing.large,
                      radius: BorderRadius.circular(LemonRadius.small * 2),
                      mode: GradientButtonMode.lavenderMode,
                      label: buttonTitle,
                      // loadingWhen: state is BuyTicketsWithCryptoStateLoading,
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
