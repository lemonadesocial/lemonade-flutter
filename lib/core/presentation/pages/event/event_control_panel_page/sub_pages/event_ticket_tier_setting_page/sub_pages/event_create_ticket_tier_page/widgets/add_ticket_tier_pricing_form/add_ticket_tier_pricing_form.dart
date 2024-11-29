import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_ticket_price_bloc/modify_ticket_price_bloc.dart';
import 'package:app/core/application/payment/connect_payment_account_bloc/connect_payment_account_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/add_ticket_tier_pricing_form/erc20_pricing_method_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/add_ticket_tier_pricing_form/fiat_pricing_method_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
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
import 'package:collection/collection.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart' as web3modal;

enum TicketPricingMethod {
  fiat,
  erc20,
}

class AddTicketTierPricingForm extends StatelessWidget {
  final Function(TicketPriceInput ticketPrice)? onConfirm;
  final TicketPriceInput? initialTicketPrice;
  final Chain? initialChain;

  const AddTicketTierPricingForm({
    super.key,
    this.onConfirm,
    this.initialTicketPrice,
    this.initialChain,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (eventDetail) => eventDetail,
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ModifyTicketPriceBloc(
            initialTicketPrice: initialTicketPrice,
            initialNetwork: initialChain,
          )..add(
              ModifyTicketPriceEvent.populateTicketPrice(),
            ),
        ),
        BlocProvider(
          create: (context) => ConnectPaymentAccountBloc(
            event: event ?? Event(),
          ),
        ),
      ],
      child: AddTicketTierPricingFormView(
        onConfirm: onConfirm,
      ),
    );
  }
}

class AddTicketTierPricingFormView extends StatefulWidget {
  final Function(TicketPriceInput ticketPrice)? onConfirm;

  const AddTicketTierPricingFormView({
    super.key,
    this.onConfirm,
  });

  @override
  State<AddTicketTierPricingFormView> createState() =>
      _AddTicketTierPricingFormViewState();
}

class _AddTicketTierPricingFormViewState
    extends State<AddTicketTierPricingFormView> {
  TicketPricingMethod pricingMethod = TicketPricingMethod.fiat;
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final initialTicketPrice =
        context.read<ModifyTicketPriceBloc>().initialTicketPrice;
    // TODO: ticket setup
    // if (initialTicketPrice?.network?.isNotEmpty == true) {
    //   setState(() {
    //     pricingMethod = TicketPricingMethod.erc20;
    //   });
    // }
  }

  void resetAmount() {
    amountController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final rootContext = context;
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    final stripePaymentAccount =
        event?.paymentAccountsExpanded?.firstWhereOrNull(
      (item) => item.provider == PaymentProvider.stripe,
    );

    return BlocListener<ConnectPaymentAccountBloc, ConnectPaymentAccountState>(
      listener: (context, connectPaymentAccState) {
        connectPaymentAccState.maybeWhen(
          orElse: () => null,
          paymentAccountConnected: (updatedEvent) {
            if (updatedEvent != null) {
              context.read<GetEventDetailBloc>().add(
                    GetEventDetailEvent.replace(event: updatedEvent),
                  );
            }
            final modifyPriceBlocState =
                context.read<ModifyTicketPriceBloc>().state;
            final decimals = pricingMethod == TicketPricingMethod.fiat
                ? (stripePaymentAccount
                        ?.accountInfo
                        ?.currencyMap?[modifyPriceBlocState.currency]
                        ?.decimals ??
                    0)
                : modifyPriceBlocState.network?.tokens
                        ?.firstWhereOrNull(
                          (element) =>
                              element.symbol == modifyPriceBlocState.currency,
                        )
                        ?.decimals ??
                    0;
            final ticketPricingInput =
                context.read<ModifyTicketPriceBloc>().getResult(
                      modifyPriceBlocState,
                      decimals: decimals.toInt(),
                    );
            if (ticketPricingInput == null) {
              return;
            }
            widget.onConfirm?.call(ticketPricingInput);
          },
        );
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: LemonColor.atomicBlack,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LemonAppBar(
                title: "",
                backgroundColor: LemonColor.atomicBlack,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.event.ticketTierSetting.paymentMethod,
                      style: Typo.extraLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        fontFamily: FontFamily.nohemiVariable,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      t.event.ticketTierSetting.howUserPay,
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: Spacing.large),
                    Row(
                      children: [
                        Expanded(
                          child: _PricingMethodItem(
                            onTap: () {
                              setState(() {
                                pricingMethod = TicketPricingMethod.fiat;
                              });
                              context
                                  .read<ModifyTicketPriceBloc>()
                                  .add(ModifyTicketPriceEvent.reset());
                              resetAmount();
                            },
                            selected: pricingMethod == TicketPricingMethod.fiat,
                            label: t.event.ticketTierSetting.creditDebit,
                            leadingBuilder: (color) =>
                                Assets.icons.icCreditCard.svg(
                              height: Sizing.xSmall,
                              width: Sizing.xSmall,
                              colorFilter:
                                  ColorFilter.mode(color, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        SizedBox(width: Spacing.xSmall),
                        Expanded(
                          child: _PricingMethodItem(
                            onTap: () {
                              setState(() {
                                pricingMethod = TicketPricingMethod.erc20;
                              });
                              context
                                  .read<ModifyTicketPriceBloc>()
                                  .add(ModifyTicketPriceEvent.reset());
                              resetAmount();
                            },
                            selected:
                                pricingMethod == TicketPricingMethod.erc20,
                            label: t.event.ticketTierSetting.erc20,
                            leadingBuilder: (color) => Assets.icons.icToken.svg(
                              colorFilter:
                                  ColorFilter.mode(color, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.large),
                    if (pricingMethod == TicketPricingMethod.fiat)
                      FiatPricingMethodForm(
                        stripePaymentAccount: stripePaymentAccount,
                        amountController: amountController,
                      ),
                    if (pricingMethod == TicketPricingMethod.erc20)
                      ERC20PricingMethodForm(
                        amountController: amountController,
                      ),
                  ],
                ),
              ),
              const Spacer(),
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, walletState) {
                  return Container(
                    color: LemonColor.atomicBlack,
                    padding: EdgeInsets.all(Spacing.smMedium),
                    child: SafeArea(
                      child: BlocBuilder<ConnectPaymentAccountBloc,
                          ConnectPaymentAccountState>(
                        builder: (context, connectPaymentAccountState) =>
                            BlocBuilder<ModifyTicketPriceBloc,
                                ModifyTicketPriceState>(
                          builder: (context, modifyTicketPriceState) {
                            final isConnectingPaymentAccount =
                                connectPaymentAccountState.maybeWhen(
                              orElse: () => false,
                              checkingPaymentAccount: () => true,
                            );
                            final isValid = pricingMethod ==
                                    TicketPricingMethod.fiat
                                ? modifyTicketPriceState.isValid
                                : modifyTicketPriceState.isValid &&
                                    modifyTicketPriceState.network != null &&
                                    walletState.activeSession != null;
                            return Opacity(
                              opacity: isValid ? 1 : 0.5,
                              child: LinearGradientButton(
                                onTap: () {
                                  final currency =
                                      modifyTicketPriceState.currency;
                                  final selectedChain =
                                      modifyTicketPriceState.network;
                                  final userWalletAddress =
                                      walletState.activeSession?.address ?? '';
                                  if (!isValid || isConnectingPaymentAccount) {
                                    return;
                                  }
                                  rootContext
                                      .read<ConnectPaymentAccountBloc>()
                                      .add(
                                        ConnectPaymentAccountEvent
                                            .checkEventHasPaymentAccount(
                                          currency: currency!,
                                          selectedChain: selectedChain,
                                          userWalletAddress: pricingMethod ==
                                                  TicketPricingMethod.fiat
                                              ? null
                                              : userWalletAddress,
                                        ),
                                      );
                                },
                                height: 42.w,
                                radius: BorderRadius.circular(
                                  LemonRadius.small * 2,
                                ),
                                mode: GradientButtonMode.lavenderMode,
                                label: t.common.confirm,
                                textStyle: Typo.medium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                loadingWhen: isConnectingPaymentAccount,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PricingMethodItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget Function(Color color)? leadingBuilder;
  final Function()? onTap;

  const _PricingMethodItem({
    required this.label,
    required this.selected,
    this.leadingBuilder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Sizing.xLarge,
        decoration: BoxDecoration(
          border: Border.all(
            width: selected ? 2.w : 1.w,
            color:
                selected ? LemonColor.paleViolet : colorScheme.onSurfaceVariant,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingBuilder != null) ...[
              leadingBuilder!.call(
                selected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: Spacing.xSmall),
            ],
            Text(
              label,
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: selected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
