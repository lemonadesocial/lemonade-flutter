import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_slide_to_pay.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/slide_to_act/slide_to_act.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/presentation/widgets/web3/wallet_connect_active_session.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayByCryptoButton extends StatelessWidget {
  final EventTicketsPricingInfo pricingInfo;
  final String selectedCurrency;
  final String? selectedNetwork;
  final List<PurchasableItem> selectedTickets;
  final bool isFree;

  const PayByCryptoButton({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
    this.selectedNetwork,
    this.isFree = false,
  });

  @override
  Widget build(BuildContext context) {
    return PayByCryptoButtonView(
      pricingInfo: pricingInfo,
      selectedCurrency: selectedCurrency,
      selectedNetwork: selectedNetwork,
      selectedTickets: selectedTickets,
      isFree: isFree,
    );
  }
}

class PayByCryptoButtonView extends StatefulWidget {
  final EventTicketsPricingInfo pricingInfo;
  final String selectedCurrency;
  final String? selectedNetwork;
  final List<PurchasableItem> selectedTickets;
  final bool isFree;

  const PayByCryptoButtonView({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
    required this.selectedTickets,
    this.selectedNetwork,
    this.isFree = false,
  });

  @override
  State<PayByCryptoButtonView> createState() => _PayByCryptoButtonViewState();
}

class _PayByCryptoButtonViewState extends State<PayByCryptoButtonView> {
  final _slideToActionKey = GlobalKey<SlideActionState>();

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
            final event = context.read<EventProviderBloc>().event;

            if (widget.isFree) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EventOrderSlideToPay(
                    onSlideToPay: () => clickInitPaymentAndSigned(
                      event: event,
                      userWalletAddress: '',
                    ),
                    slideActionKey: _slideToActionKey,
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

            final w3mService = getIt<WalletConnectService>().w3mService;
            final userWalletAddress = w3mService.address ?? '';

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
                    WalletConnectActiveSessionWidget(
                      title: t.event.eventPayment.payUsing,
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
