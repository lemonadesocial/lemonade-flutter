import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_ticket_price_bloc/modify_ticket_price_bloc.dart';
import 'package:app/core/application/payment/connect_payment_account_bloc/connect_payment_account_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/get_chains_list_builder.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

enum TicketPricingMethod {
  fiat,
  erc20,
}

class AddTicketTierPricingForm extends StatelessWidget {
  final Function(TicketPriceInput ticketPrice)? onConfirm;

  const AddTicketTierPricingForm({
    super.key,
    this.onConfirm,
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
          create: (context) => ModifyTicketPriceBloc(),
        ),
        BlocProvider(
          create: (context) => ConnectPaymentAccountBloc(
            event: event ?? Event(),
          ),
        ),
        BlocProvider(
          create: (context) => WalletBloc()
            ..add(
              const WalletEvent.getActiveSessions(),
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
        child: LemonSnapBottomSheet(
          defaultSnapSize: 1,
          backgroundColor: LemonColor.atomicBlack,
          resizeToAvoidBottomInset: false,
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      FiatPricingMethod(
                        stripePaymentAccount: stripePaymentAccount,
                      ),
                    if (pricingMethod == TicketPricingMethod.erc20)
                      const ERC20PricingMethod(),
                  ],
                ),
              ),
            ],
          ),
          footerBuilder: () => BlocBuilder<WalletBloc, WalletState>(
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
                        final isValid =
                            pricingMethod == TicketPricingMethod.fiat
                                ? modifyTicketPriceState.isValid
                                : modifyTicketPriceState.isValid &&
                                    modifyTicketPriceState.network != null &&
                                    walletState.activeSession != null;
                        return Opacity(
                          opacity: isValid ? 1 : 0.5,
                          child: LinearGradientButton(
                            onTap: () {
                              final currency = modifyTicketPriceState.currency;
                              final selectedChain =
                                  modifyTicketPriceState.network;
                              final userWalletAddress =
                                  NamespaceUtils.getAccount(
                                walletState.activeSession?.namespaces.entries
                                        .first.value.accounts.first ??
                                    '',
                              );
                              if (!isValid || isConnectingPaymentAccount) {
                                return;
                              }
                              rootContext.read<ConnectPaymentAccountBloc>().add(
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
                            radius:
                                BorderRadius.circular(LemonRadius.small * 2),
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
        ),
      ),
    );
  }
}

class FiatPricingMethod extends StatelessWidget {
  final PaymentAccount? stripePaymentAccount;

  const FiatPricingMethod({
    super.key,
    this.stripePaymentAccount,
  });

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<ModifyTicketPriceBloc>().state.currency;
    final currencies = stripePaymentAccount?.accountInfo?.currencies ?? [];
    final decimals = currency != null
        ? (stripePaymentAccount
                ?.accountInfo?.currencyMap?[currency]?.decimals ??
            0)
        : 0;
    final currencyFormatter = CurrencyTextInputFormatter(
      symbol: '',
      decimalDigits: decimals,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.event.ticketTierSetting.whatTicketPrice),
        SizedBox(height: Spacing.xSmall),
        Row(
          children: [
            BlocBuilder<ModifyTicketPriceBloc, ModifyTicketPriceState>(
              builder: (context, state) {
                return Expanded(
                  child: _Dropdown<String?>(
                    value: state.currency,
                    getDisplayValue: (v) => v ?? '',
                    placeholder: t.event.ticketTierSetting.currency,
                    onTap: () => BottomSheetUtils.showSnapBottomSheet(
                      context,
                      builder: (_) => _DropdownList<String, String>(
                        data: currencies,
                        getDisplayLabel: (v) => v,
                        getValue: (v) => v,
                        onConfirm: (item) {
                          context.router.pop();
                          context.read<ModifyTicketPriceBloc>().add(
                                ModifyTicketPriceEvent.onCurrencyChanged(
                                  currency: item ?? '',
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: BlocBuilder<ModifyTicketPriceBloc, ModifyTicketPriceState>(
                builder: (context, state) => LemonTextField(
                  onChange: (value) {
                    context.read<ModifyTicketPriceBloc>().add(
                          ModifyTicketPriceEvent.onCostChanged(
                            cost: currencyFormatter
                                .getUnformattedValue()
                                .toString(),
                          ),
                        );
                  },
                  readOnly: state.currency == null,
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    currencyFormatter,
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ERC20PricingMethod extends StatelessWidget {
  const ERC20PricingMethod({super.key});
  @override
  Widget build(BuildContext context) {
    return GetChainsListBuilder(
      builder: (context, chains) => BlocBuilder<WalletBloc, WalletState>(
        builder: (context, walletState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.event.ticketTierSetting.whatTicketTokenPrice),
              SizedBox(height: Spacing.xSmall),
              BlocBuilder<ModifyTicketPriceBloc, ModifyTicketPriceState>(
                builder: (context, state) => _Dropdown<Chain?>(
                  value: state.network,
                  placeholder: t.event.ticketTierSetting.selectChain,
                  getDisplayValue: (chain) => chain?.name ?? '',
                  onTap: () => BottomSheetUtils.showSnapBottomSheet(
                    context,
                    builder: (_) => _DropdownList<Chain, Chain>(
                      data: chains,
                      getDisplayLabel: (chain) => chain.name ?? '',
                      getValue: (chain) => chain,
                      onConfirm: (item) {
                        if (item == null) return;
                        context.router.pop();
                        context.read<ModifyTicketPriceBloc>().add(
                              ModifyTicketPriceEvent.onNetworkChanged(
                                network: item,
                              ),
                            );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<ModifyTicketPriceBloc,
                        ModifyTicketPriceState>(
                      builder: (context, state) {
                        return _Dropdown<String>(
                          placeholder: t.event.ticketTierSetting.token,
                          value: state.currency,
                          getDisplayValue: (tokenSymbol) => tokenSymbol ?? '',
                          onTap: () => BottomSheetUtils.showSnapBottomSheet(
                            context,
                            builder: (_) => _DropdownList<String, String>(
                              data: state.network?.tokens
                                      ?.map((item) => item.symbol ?? '')
                                      .toList() ??
                                  [],
                              getDisplayLabel: (tokenSymbol) => tokenSymbol,
                              getValue: (tokenSymbol) => tokenSymbol,
                              onConfirm: (item) {
                                if (item == null) return;
                                context.router.pop();
                                context.read<ModifyTicketPriceBloc>().add(
                                      ModifyTicketPriceEvent.onCurrencyChanged(
                                        currency: item,
                                      ),
                                    );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                  Expanded(
                    child: BlocBuilder<ModifyTicketPriceBloc,
                        ModifyTicketPriceState>(
                      builder: (context, state) {
                        return LemonTextField(
                          onChange: (value) {
                            context.read<ModifyTicketPriceBloc>().add(
                                  ModifyTicketPriceEvent.onCostChanged(
                                    cost: value,
                                  ),
                                );
                          },
                          readOnly:
                              state.currency == null || state.network == null,
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: NumberUtils.currencyInputFormatters,
                        );
                      },
                    ),
                  ),
                ],
              ),
              if (walletState.activeSession == null) ...[
                SizedBox(height: Spacing.xSmall),
                ConnectWalletButton(
                  onSelect: (walletApp) {
                    context.read<WalletBloc>().add(
                          WalletEvent.connectWallet(walletApp: walletApp),
                        );
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final T? value;
  final String Function(T? value)? getDisplayValue;
  final Widget Function(T? value)? leadingBuilder;
  final String? placeholder;
  final Function()? onTap;

  const _Dropdown({
    super.key,
    this.value,
    this.getDisplayValue,
    this.leadingBuilder,
    this.placeholder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
        height: Sizing.xLarge,
        child: Row(
          children: [
            if (leadingBuilder != null) ...[
              leadingBuilder!.call(value),
              SizedBox(width: Spacing.xSmall),
            ],
            if (value == null)
              Expanded(
                child: Text(
                  placeholder ?? '',
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.outlineVariant,
                  ),
                ),
              ),
            if (value != null)
              Expanded(
                child: Text(
                  getDisplayValue?.call(value) ?? '',
                  style: Typo.mediumPlus,
                ),
              ),
            Assets.icons.icArrowDown.svg(
              color: colorScheme.onSurfaceVariant,
            ),
          ],
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

class _DropdownList<T, V> extends StatefulWidget {
  final List<T> data;
  final String Function(T item) getDisplayLabel;
  final V Function(T item) getValue;
  final String? title;
  final V? value;
  final Function(T? item)? onConfirm;

  const _DropdownList({
    super.key,
    this.value,
    required this.data,
    this.onConfirm,
    required this.getDisplayLabel,
    required this.getValue,
    this.title,
  });

  @override
  State<_DropdownList<T, V>> createState() => _DropdownListState<T, V>();
}

class _DropdownListState<T, V> extends State<_DropdownList<T, V>> {
  V? value;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LemonSnapBottomSheet(
      defaultSnapSize: 1,
      backgroundColor: LemonColor.atomicBlack,
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LemonAppBar(
              title: widget.title ?? '',
              backgroundColor: LemonColor.atomicBlack,
            ),
            SizedBox(
              height: 0.69.sh,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      final item = widget.data[index];
                      final itemValue = widget.getValue(item);
                      final selected = itemValue == value;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            value = itemValue;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                            vertical: Spacing.extraSmall,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.getDisplayLabel(widget.data[index]),
                                  style: Typo.mediumPlus,
                                ),
                              ),
                              if (!selected) Assets.icons.icUncheck.svg(),
                              if (selected) Assets.icons.icChecked.svg(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
      footerBuilder: () => Container(
        color: LemonColor.atomicBlack,
        padding: EdgeInsets.all(Spacing.smMedium),
        child: SafeArea(
          child: LinearGradientButton(
            onTap: () {
              widget.onConfirm?.call(
                widget.data
                    .firstWhereOrNull((item) => widget.getValue(item) == value),
              );
            },
            height: 42.w,
            radius: BorderRadius.circular(LemonRadius.small * 2),
            mode: GradientButtonMode.lavenderMode,
            label: t.common.confirm,
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
