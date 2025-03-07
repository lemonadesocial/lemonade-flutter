import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_pricing_form_v2/widgets/ticket_tier_add_direct_crypto_price_form_popup.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_pricing_form_v2/widgets/ticket_tier_add_price_button.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_pricing_form_v2/widgets/ticket_tier_add_stake_crypto_price_form_popup.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_pricing_form_v2/widgets/ticket_tier_add_stripe_price_form_popup.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_stripe_payment_account_page/event_setup_stripe_payment_account_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum TicketTierPricingFormV2Type {
  free,
  direct,
  staking,
}

class TicketTierPricingFormV2 extends StatefulWidget {
  final List<PaymentAccount> eventLevelPaymentAccounts;
  const TicketTierPricingFormV2({
    super.key,
    required this.eventLevelPaymentAccounts,
  });

  @override
  State<TicketTierPricingFormV2> createState() =>
      _TicketTierPricingFormV2State();
}

class _TicketTierPricingFormV2State extends State<TicketTierPricingFormV2>
    with TickerProviderStateMixin {
  TicketTierPricingFormV2Type _pricingType = TicketTierPricingFormV2Type.free;
  late TabController _tabbarController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.ticketTierSetting.pricing,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Container(
          height: Sizing.large,
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: BorderRadius.circular(LemonRadius.small),
            border: Border.all(
              color: colorScheme.outline,
            ),
          ),
          child: TabBar(
            controller: _tabbarController,
            padding: EdgeInsets.symmetric(
              vertical: Spacing.superExtraSmall,
              horizontal: 0,
            ),
            indicatorWeight: 0,
            labelPadding: EdgeInsets.all(Spacing.superExtraSmall),
            indicatorPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                LemonRadius.extraSmall,
              ),
              border: Border.all(
                color: colorScheme.outlineVariant,
              ),
              color: LemonColor.chineseBlack,
            ),
            tabs: [
              Tab(
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      t.event.ticketTierSetting.free,
                      style: Typo.medium.copyWith(
                        color: _pricingType == TicketTierPricingFormV2Type.free
                            ? colorScheme.onPrimary
                            : colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      t.event.ticketTierSetting.direct,
                      style: Typo.medium.copyWith(
                        color:
                            _pricingType == TicketTierPricingFormV2Type.direct
                                ? colorScheme.onPrimary
                                : colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      t.event.ticketTierSetting.staking,
                      style: Typo.medium.copyWith(
                        color:
                            _pricingType == TicketTierPricingFormV2Type.staking
                                ? colorScheme.onPrimary
                                : colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_pricingType == TicketTierPricingFormV2Type.direct)
          BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: Spacing.xSmall),
                  TicketTierAddPriceButton(
                    ticketPrice: stripePriceAndPaymentAccounts.$1,
                    paymentAccounts: stripePriceAndPaymentAccounts.$2,
                    label: t.event.ticketTierSetting.addCardPrice,
                    onTap: _onTapStripe,
                    icon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (colorFilter) => Assets.icons.icCreditCard.svg(
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                        colorFilter: colorFilter,
                      ),
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  TicketTierAddPriceButton(
                    ticketPrice: cryptoPriceAndPaymentAccounts.$1,
                    paymentAccounts: cryptoPriceAndPaymentAccounts.$2,
                    label: t.event.ticketTierSetting.addCryptoPrice,
                    onTap: _onTapCryptoRelay,
                    icon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (colorFilter) => Assets.icons.icWallet.svg(
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                        colorFilter: colorFilter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        if (_pricingType == TicketTierPricingFormV2Type.staking)
          BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: Spacing.xSmall),
                  TicketTierAddPriceButton(
                    ticketPrice: stakePriceAndPaymentAccounts.$1,
                    paymentAccounts: stakePriceAndPaymentAccounts.$2,
                    label: t.event.ticketTierSetting.addStakePrice,
                    onTap: _onTapStaking,
                    icon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (colorFilter) => Assets.icons.icWallet.svg(
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                        colorFilter: colorFilter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabbarController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (_tabbarController.index == 0) {
          _onSelectType(TicketTierPricingFormV2Type.free);
          _onTapFree();
        } else if (_tabbarController.index == 1) {
          _onSelectType(TicketTierPricingFormV2Type.direct);
        } else {
          _onSelectType(TicketTierPricingFormV2Type.staking);
        }
      });
    _checkInitialFormType();
  }

  (TicketPriceInput?, List<PaymentAccount> paymentAccounts)
      get stripePriceAndPaymentAccounts {
    final price =
        context.read<ModifyTicketTypeBloc>().state.prices.firstWhereOrNull(
              (element) =>
                  element.paymentAccounts?.any(
                    _isCorrectPaymentAccountType(PaymentAccountType.digital),
                  ) ==
                  true,
            );
    final paymentAccounts =
        getPaymentAccountsDetailByIds(price?.paymentAccounts ?? []);
    return (price, paymentAccounts);
  }

  (TicketPriceInput?, List<PaymentAccount> paymentAccounts)
      get cryptoPriceAndPaymentAccounts {
    final price =
        context.read<ModifyTicketTypeBloc>().state.prices.firstWhereOrNull(
              (element) =>
                  element.paymentAccounts?.any(
                    _isCorrectPaymentAccountType(
                      PaymentAccountType.ethereumRelay,
                    ),
                  ) ==
                  true,
            );
    final paymentAccounts =
        getPaymentAccountsDetailByIds(price?.paymentAccounts ?? []);
    return (price, paymentAccounts);
  }

  (TicketPriceInput?, List<PaymentAccount> paymentAccounts)
      get stakePriceAndPaymentAccounts {
    final price =
        context.read<ModifyTicketTypeBloc>().state.prices.firstWhereOrNull(
              (element) =>
                  element.paymentAccounts?.any(
                    _isCorrectPaymentAccountType(
                      PaymentAccountType.ethereumStake,
                    ),
                  ) ==
                  true,
            );
    final paymentAccounts =
        getPaymentAccountsDetailByIds(price?.paymentAccounts ?? []);
    return (price, paymentAccounts);
  }

  bool Function(String payaccId) _isCorrectPaymentAccountType(
    PaymentAccountType type,
  ) =>
      (String payaccId) {
        return widget.eventLevelPaymentAccounts.any(
          (eventLevelPayacc) =>
              eventLevelPayacc.id == payaccId && eventLevelPayacc.type == type,
        );
      };

  List<PaymentAccount> getPaymentAccountsDetailByIds(List<String> ids) {
    return ids
        .map(
          (e) => widget.eventLevelPaymentAccounts
              .firstWhereOrNull((element) => element.id == e),
        )
        .nonNulls
        .toList();
  }

  _onSelectType(TicketTierPricingFormV2Type type) {
    if (_pricingType == type) {
      return;
    }
    setState(() {
      _pricingType = type;
    });
    context.read<ModifyTicketTypeBloc>().add(
          ModifyTicketTypeEvent.onPricesChanged(
            ticketPrices: [],
          ),
        );
  }

  _checkInitialFormType() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final prices = context.read<ModifyTicketTypeBloc>().state.prices;
    final allPaymentAccounts = prices
        .expand((element) => element.paymentAccounts ?? <String>[])
        .toList();
    if (allPaymentAccounts.isEmpty) {
      _pricingType = TicketTierPricingFormV2Type.free;
    } else if (allPaymentAccounts
            .any(_isCorrectPaymentAccountType(PaymentAccountType.digital)) ||
        allPaymentAccounts.any(
          _isCorrectPaymentAccountType(PaymentAccountType.ethereumRelay),
        )) {
      _pricingType = TicketTierPricingFormV2Type.direct;
    } else {
      _pricingType = TicketTierPricingFormV2Type.staking;
    }
    _tabbarController.animateTo(
      _pricingType == TicketTierPricingFormV2Type.free
          ? 0
          : _pricingType == TicketTierPricingFormV2Type.direct
              ? 1
              : 2,
    );
    setState(() {});
  }

  List<TicketPriceInput> generateNewPrices(
    List<TicketPriceInput> currentPrices,
    TicketPriceInput newPrice,
    PaymentAccountType type,
  ) {
    bool replaced = false;
    final newPrices = [...currentPrices].map((price) {
      if (price.paymentAccounts != null &&
          price.paymentAccounts!.any(_isCorrectPaymentAccountType(type))) {
        replaced = true;
        return newPrice;
      }
      return price;
    }).toList();
    if (!replaced) {
      newPrices.add(newPrice);
    }
    return newPrices;
  }

  void _onTapStripe() async {
    PaymentAccount? stripePaymentAccount =
        widget.eventLevelPaymentAccounts.firstWhereOrNull(
      (element) => element.provider == PaymentProvider.stripe,
    );
    stripePaymentAccount ??=
        await showCupertinoModalBottomSheet<PaymentAccount>(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      expand: false,
      builder: (context) => const EventSetupStripePaymentAccountPage(),
    );
    if (stripePaymentAccount == null) {
      return;
    }
    final newPrice = await showCupertinoModalBottomSheet<TicketPriceInput?>(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      expand: false,
      builder: (context) => TicketTierAddStripePriceFormPopup(
        eventLevelStripePaymentAccount: stripePaymentAccount!,
        initialPriceInput: stripePriceAndPaymentAccounts.$1,
      ),
    );
    if (newPrice == null) {
      return;
    }
    final state = context.read<ModifyTicketTypeBloc>().state;
    final newPrices = generateNewPrices(
      [...state.prices],
      newPrice,
      PaymentAccountType.digital,
    );
    context.read<ModifyTicketTypeBloc>().add(
          ModifyTicketTypeEvent.onPricesChanged(
            ticketPrices: newPrices,
          ),
        );
  }

  void _onTapCryptoRelay() async {
    final eventLevelDirectCryptoPaymentAccounts =
        widget.eventLevelPaymentAccounts
            .where(
              (element) => element.type == PaymentAccountType.ethereumRelay,
            )
            .toList();
    final newPrice = await showCupertinoModalBottomSheet<TicketPriceInput?>(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => TicketTierAddDirectCryptoFormPopup(
        eventLevelDirectCryptoPaymentAccounts:
            eventLevelDirectCryptoPaymentAccounts,
        initialTicketPrice: cryptoPriceAndPaymentAccounts.$1,
      ),
    );
    if (newPrice == null) {
      return;
    }
    final state = context.read<ModifyTicketTypeBloc>().state;
    final newPrices = generateNewPrices(
      [...state.prices],
      newPrice,
      PaymentAccountType.ethereumRelay,
    );
    context.read<ModifyTicketTypeBloc>().add(
          ModifyTicketTypeEvent.onPricesChanged(
            ticketPrices: newPrices,
          ),
        );
  }

  void _onTapStaking() async {
    final eventLevelStakePaymentAccounts = widget.eventLevelPaymentAccounts
        .where(
          (element) => element.type == PaymentAccountType.ethereumStake,
        )
        .toList();
    final newPrice = await showCupertinoModalBottomSheet<TicketPriceInput?>(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => TicketTierAddStakeCryptoPriceFormPopup(
        eventLevelStakePaymentAccounts: eventLevelStakePaymentAccounts,
        initialTicketPrice: stakePriceAndPaymentAccounts.$1,
      ),
    );
    if (newPrice == null) {
      return;
    }
    final state = context.read<ModifyTicketTypeBloc>().state;
    final newPrices = generateNewPrices(
      [...state.prices],
      newPrice,
      PaymentAccountType.ethereumRelay,
    );
    context.read<ModifyTicketTypeBloc>().add(
          ModifyTicketTypeEvent.onPricesChanged(
            ticketPrices: newPrices,
          ),
        );
  }

  void _onTapFree() {
    context.read<ModifyTicketTypeBloc>().add(
          ModifyTicketTypeEvent.onPricesChanged(
            ticketPrices: [
              TicketPriceInput(
                cost: '0',
                currency: 'USD',
                paymentAccounts: null,
              ),
            ],
          ),
        );
  }
}
