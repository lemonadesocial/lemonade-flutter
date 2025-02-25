import 'package:app/core/application/event_tickets/modify_ticket_price_v2_bloc/modify_ticket_price_v2_bloc.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/get_chains_list_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_dropdown.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_direct_crypto_payment_account_page/event_setup_direct_crypto_payment_account_page.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:collection/collection.dart';

class TicketTierAddDirectCryptoFormPopup extends StatelessWidget {
  final List<PaymentAccount> eventLevelDirectCryptoPaymentAccounts;
  final TicketPriceInput? initialTicketPrice;
  const TicketTierAddDirectCryptoFormPopup({
    super.key,
    required this.eventLevelDirectCryptoPaymentAccounts,
    this.initialTicketPrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ModifyTicketPriceV2Bloc(initialTicketPrice: initialTicketPrice),
      child: _View(
        eventLevelDirectCryptoPaymentAccounts:
            eventLevelDirectCryptoPaymentAccounts,
      ),
    );
  }
}

class _View extends StatefulWidget {
  final List<PaymentAccount> eventLevelDirectCryptoPaymentAccounts;
  const _View({
    required this.eventLevelDirectCryptoPaymentAccounts,
  });

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final TextEditingController amountController = TextEditingController();
  List<PaymentAccount> availablePaymentAccounts = [];

  @override
  void initState() {
    super.initState();
    availablePaymentAccounts = widget.eventLevelDirectCryptoPaymentAccounts;
    final initialTicketPrice =
        context.read<ModifyTicketPriceV2Bloc>().initialTicketPrice;
    if (initialTicketPrice == null) {
      return;
    }
    final paymentAccountId = initialTicketPrice.paymentAccounts?.firstOrNull;
    final paymentAccount = availablePaymentAccounts
        .firstWhereOrNull((e) => e.id == paymentAccountId);
    final initialDecimals = paymentAccount?.accountInfo
            ?.currencyMap?[initialTicketPrice.currency]?.decimals ??
        18;
    final initialAmount = Web3Utils.formatCryptoCurrency(
      BigInt.parse(initialTicketPrice.cost),
      currency: '',
      decimals: initialDecimals.toInt(),
    );
    amountController.text = initialAmount;
    context.read<ModifyTicketPriceV2Bloc>().add(
          ModifyTicketPriceV2Event.onCurrencyChanged(
            currency: initialTicketPrice.currency,
          ),
        );
    context.read<ModifyTicketPriceV2Bloc>().add(
          ModifyTicketPriceV2Event.onPaymentAccountSelected(
            paymentAccounts: initialTicketPrice.paymentAccounts ?? [],
          ),
        );
  }

  Map<String, List<Chain>> _getTokensBySymbol(List<Chain> chains) {
    final tokenMap = <String, List<Chain>>{};

    for (final chain in chains) {
      final tokens = chain.tokens ?? [];
      for (final token in tokens) {
        final symbol = token.symbol;
        if (symbol == null) continue;

        tokenMap.putIfAbsent(symbol, () => []);
        tokenMap[symbol]!.add(chain);
      }
    }

    return tokenMap;
  }

  void _resetAmount() {
    amountController.text = '';
  }

  String _transformCost(ModifyTicketPriceV2State state) {
    final decimals = availablePaymentAccounts
            .firstWhereOrNull(
              (e) => state.selectedPaymentAccounts?.contains(e.id) ?? false,
            )
            ?.accountInfo
            ?.currencyMap?[state.currency]
            ?.decimals ??
        18;

    final parts = state.cost!.split('.');

    String transformedCost;
    if (parts.length == 1) {
      // No decimal point
      transformedCost = parts[0] + '0' * decimals;
    } else {
      final integerPart = parts[0];
      final decimalPart = parts[1].padRight(decimals, '0');
      transformedCost = integerPart + decimalPart;
    }
    // Remove leading zeros
    transformedCost = BigInt.parse(transformedCost).toString();
    return transformedCost;
  }

  void _onConfirm(ModifyTicketPriceV2State state) {
    final transformedCost = _transformCost(state);

    Navigator.of(context).pop(
      TicketPriceInput(
        cost: transformedCost,
        currency: state.currency!,
        paymentAccounts: state.selectedPaymentAccounts ?? [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return GetChainsListBuilder(
      builder: (context, chains) {
        final tokensBySymbol = _getTokensBySymbol(chains);
        final availableTokens = tokensBySymbol.keys.toList();

        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: BottomSheetGrabber(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.event.ticketTierSetting.cryptoPrice,
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            t.event.ticketTierSetting.cryptoPriceDescription,
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(height: Spacing.xSmall),
                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<ModifyTicketPriceV2Bloc,
                                    ModifyTicketPriceV2State>(
                                  builder: (context, state) {
                                    return LemonTextField(
                                      filled: true,
                                      fillColor: colorScheme.onPrimary
                                          .withOpacity(0.06),
                                      borderColor: Colors.transparent,
                                      controller: amountController,
                                      hintText:
                                          t.event.ticketTierSetting.enterPrice,
                                      onChange: (value) {
                                        context
                                            .read<ModifyTicketPriceV2Bloc>()
                                            .add(
                                              ModifyTicketPriceV2Event
                                                  .onCostChanged(
                                                cost: value,
                                              ),
                                            );
                                      },
                                      readOnly: state.currency == null,
                                      textInputType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      inputFormatters:
                                          NumberUtils.currencyInputFormatters,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: Spacing.xSmall),
                              Expanded(
                                child: BlocBuilder<ModifyTicketPriceV2Bloc,
                                    ModifyTicketPriceV2State>(
                                  builder: (context, state) {
                                    return TicketTierFeatureDropdown<String>(
                                      placeholder:
                                          t.event.ticketTierSetting.token,
                                      value: state.currency,
                                      getDisplayValue: (tokenSymbol) =>
                                          tokenSymbol ?? '',
                                      onTap: () =>
                                          showCupertinoModalBottomSheet(
                                        context: context,
                                        expand: true,
                                        backgroundColor: LemonColor.atomicBlack,
                                        builder: (innerContext) =>
                                            TicketTierFeatureDropdownList<
                                                String, String>(
                                          value: state.currency,
                                          data: availableTokens,
                                          getDisplayLabel: (symbol) {
                                            return symbol;
                                          },
                                          getValue: (symbol) => symbol,
                                          onConfirm: (symbol) {
                                            if (symbol == null) return;
                                            innerContext.router.pop();
                                            context
                                                .read<ModifyTicketPriceV2Bloc>()
                                                .add(
                                                  ModifyTicketPriceV2Event
                                                      .onCurrencyChanged(
                                                    currency: symbol,
                                                  ),
                                                );
                                            _resetAmount();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: BlocBuilder<ModifyTicketPriceV2Bloc,
                                ModifyTicketPriceV2State>(
                              builder: (context, state) {
                                final currency = state.currency;
                                final selectedPaymentAccounts =
                                    state.selectedPaymentAccounts ?? [];
                                final supportedChains = currency != null
                                    ? (tokensBySymbol[currency] ?? [])
                                    : chains;

                                return _SupportedChains(
                                  chains: supportedChains,
                                  getIsSelectable: (chain) {
                                    return availablePaymentAccounts.any(
                                      (e) =>
                                          e.accountInfo?.network ==
                                          chain.chainId,
                                    );
                                  },
                                  getIsSelected: (chain) {
                                    return selectedPaymentAccounts.any(
                                      (paymentAccId) {
                                        return availablePaymentAccounts.any(
                                          (e) =>
                                              e.id == paymentAccId &&
                                              e.accountInfo?.network ==
                                                  chain.chainId,
                                        );
                                      },
                                    );
                                  },
                                  onTap: (chain, selectable, selected) async {
                                    if (!selectable) {
                                      final paymentAccount =
                                          await showCupertinoModalBottomSheet<
                                              PaymentAccount?>(
                                        context: context,
                                        backgroundColor: LemonColor.atomicBlack,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        builder: (context) =>
                                            EventSetupDirectCryptoPaymentAccountPage(
                                          chain: chain,
                                        ),
                                      );
                                      if (paymentAccount == null) {
                                        return;
                                      }
                                      setState(() {
                                        availablePaymentAccounts = [
                                          ...availablePaymentAccounts,
                                          paymentAccount,
                                        ];
                                      });
                                      return;
                                    }
                                    final paymentAccountId =
                                        availablePaymentAccounts
                                            .firstWhereOrNull(
                                              (e) =>
                                                  e.accountInfo?.network ==
                                                  chain.chainId,
                                            )
                                            ?.id;
                                    if (paymentAccountId == null) return;
                                    context.read<ModifyTicketPriceV2Bloc>().add(
                                          ModifyTicketPriceV2Event
                                              .onPaymentAccountSelected(
                                            paymentAccounts: selected
                                                ? (state.selectedPaymentAccounts ??
                                                        [])
                                                    .where(
                                                      (payAccId) =>
                                                          payAccId !=
                                                          paymentAccountId,
                                                    )
                                                    .toList()
                                                : [
                                                    ...state.selectedPaymentAccounts ??
                                                        [],
                                                    paymentAccountId,
                                                  ],
                                          ),
                                        );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: Spacing.medium),
                          BlocBuilder<ModifyTicketPriceV2Bloc,
                              ModifyTicketPriceV2State>(
                            builder: (context, state) {
                              final isValid = state.isValid &&
                                  state.selectedPaymentAccounts?.isNotEmpty ==
                                      true;
                              return Opacity(
                                opacity: isValid ? 1 : 0.5,
                                child: LinearGradientButton.primaryButton(
                                  label: t.common.confirm,
                                  onTap:
                                      isValid ? () => _onConfirm(state) : null,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: Spacing.small),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SupportedChains extends StatelessWidget {
  final List<Chain> chains;
  final bool Function(Chain chain) getIsSelectable;
  final bool Function(Chain chain) getIsSelected;
  final Function(Chain chain, bool selectable, bool selected) onTap;
  const _SupportedChains({
    required this.chains,
    required this.getIsSelectable,
    required this.getIsSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Spacing.small),
        Text(
          t.event.ticketTierSetting.selectNetworks,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: chains.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.xSmall),
            itemBuilder: (context, index) {
              final chain = chains[index];
              final selectable = getIsSelectable(chain);
              final selected = getIsSelected(chain);
              return InkWell(
                onTap: () => onTap(chain, selectable, selected),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.small,
                    vertical: Spacing.small,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? colorScheme.onPrimary.withOpacity(0.06)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                    border: Border.all(
                      color:
                          selected ? Colors.transparent : colorScheme.outline,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (chain.logoUrl != null) ...[
                        LemonNetworkImage(
                          imageUrl: chain.logoUrl ?? '',
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                        ),
                        SizedBox(width: Spacing.xSmall),
                      ],
                      Expanded(
                        child: Text(
                          chain.name ?? '',
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (selectable) ...[
                        if (selected)
                          Assets.icons.icChecked.svg()
                        else
                          Assets.icons.icCircleEmpty.svg(),
                      ],
                      if (!selectable) ...[
                        Text(
                          t.event.ticketTierSetting.activate,
                          style: Typo.medium.copyWith(
                            color: LemonColor.paleViolet,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
