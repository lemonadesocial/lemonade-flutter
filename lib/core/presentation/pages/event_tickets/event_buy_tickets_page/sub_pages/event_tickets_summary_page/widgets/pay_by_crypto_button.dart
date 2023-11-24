import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_slide_to_pay.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/slide_to_act/slide_to_act.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/wallet_connect/wallet_connect_popup/wallet_connect_popup.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class PayByCryptoButton extends StatelessWidget {
  final EventTicketsPricingInfo pricingInfo;
  final Currency selectedCurrency;
  final SupportedPaymentNetwork? selectedNetwork;
  final List<PurchasableItem> selectedTickets;

  const PayByCryptoButton({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
    this.selectedNetwork,
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
        selectedNetwork: selectedNetwork,
        selectedTickets: selectedTickets,
      ),
    );
  }
}

class PayByCryptoButtonView extends StatefulWidget {
  final EventTicketsPricingInfo pricingInfo;
  final Currency selectedCurrency;
  final SupportedPaymentNetwork? selectedNetwork;
  final List<PurchasableItem> selectedTickets;

  const PayByCryptoButtonView({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
    this.selectedNetwork,
  });

  @override
  State<PayByCryptoButtonView> createState() => _PayByCryptoButtonViewState();
}

class _PayByCryptoButtonViewState extends State<PayByCryptoButtonView> {
  final _slideToActionKey = GlobalKey<SlideActionState>();

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
              network: widget.selectedNetwork,
              discount: widget.pricingInfo.promoCode,
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
                onTap: () => showSelectWalletPopup(context),
                height: Sizing.large,
                radius: BorderRadius.circular(LemonRadius.small * 2),
                mode: GradientButtonMode.lavenderMode,
                label: t.event.eventCryptoPayment.connectWallet,
                textStyle: Typo.medium.copyWith(
                  fontFamily: FontFamily.nohemiVariable,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary.withOpacity(0.87),
                ),
              );
            }

            final sessionAccount = walletState
                .activeSession!.namespaces.entries.first.value.accounts.first;
            final userWalletAddress = NamespaceUtils.getAccount(sessionAccount);
            String displayAddress =
                Web3Utils.formatIdentifier(userWalletAddress);

            final event = context.read<EventProviderBloc>().event;
            return BlocBuilder<BuyTicketsWithCryptoBloc,
                BuyTicketsWithCryptoState>(
              builder: (context, state) {
                String buttonTitle = '';
                Function()? onPress;

                if (state is BuyTicketsWithCryptoStateFailure) {
                  _slideToActionKey.currentState?.reset();
                }

                if (state is BuyTicketsWithCryptoStateLoading) {
                  buttonTitle = t.common.processing;
                }

                if (state is BuyTicketsWithCryptoStateIdle) {
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

                if (state is BuyTicketsWithCryptoStateDone) {
                  return Text(
                    t.event.eventCryptoPayment.waitForConfirmation,
                    style: Typo.medium.copyWith(
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: LemonColor.chineseBlack,
                            borderRadius: BorderRadius.circular(
                              LemonRadius.extraSmall,
                            ),
                          ),
                          width: Sizing.medium,
                          height: Sizing.medium,
                          child: Center(
                            child: Assets.icons.icMetamask.svg(
                              width: Sizing.xSmall,
                              height: Sizing.xSmall,
                            ),
                          ),
                        ),
                        SizedBox(width: Spacing.xSmall),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.event.eventPayment.payUsing,
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                            Text(displayAddress),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          width: Sizing.medium,
                          height: Sizing.medium,
                          decoration: BoxDecoration(
                            color: colorScheme.onPrimary.withOpacity(0.09),
                            borderRadius:
                                BorderRadius.circular(LemonRadius.normal),
                          ),
                          child: Center(
                            child: ThemeSvgIcon(
                              color: colorScheme.onSurfaceVariant,
                              builder: (filter) => Assets.icons.icEdit.svg(
                                colorFilter: filter,
                                height: Sizing.xSmall,
                                width: Sizing.xSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.smMedium),
                    if (state is BuyTicketsWithCryptoStateLoading)
                      Loading.defaultLoading(context),
                    if (state is BuyTicketsWithCryptoStateSigned)
                      EventOrderSlideToPay(
                        onSlideToPay: () => onPress?.call(),
                        slideActionKey: _slideToActionKey,
                        selectedCurrency: widget.selectedCurrency,
                        selectedNetwork: widget.selectedNetwork,
                        pricingInfo: widget.pricingInfo,
                      ),
                    if (state is! BuyTicketsWithCryptoStateSigned &&
                        state is! BuyTicketsWithCryptoStateLoading)
                      LinearGradientButton(
                        onTap: () {
                          onPress?.call();
                        },
                        height: Sizing.large,
                        radius: BorderRadius.circular(LemonRadius.small * 2),
                        textStyle: Typo.medium.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary.withOpacity(0.87),
                        ),
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
