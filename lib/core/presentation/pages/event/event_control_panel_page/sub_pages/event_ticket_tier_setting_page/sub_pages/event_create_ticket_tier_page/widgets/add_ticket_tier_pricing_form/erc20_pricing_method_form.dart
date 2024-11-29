import 'package:app/core/application/event_tickets/modify_ticket_price_bloc/modify_ticket_price_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/get_chains_list_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_dropdown.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ERC20PricingMethodForm extends StatefulWidget {
  final TextEditingController amountController;

  const ERC20PricingMethodForm({super.key, required this.amountController});

  @override
  State<ERC20PricingMethodForm> createState() => _ERC20PricingMethodFormState();
}

class _ERC20PricingMethodFormState extends State<ERC20PricingMethodForm> {
  @override
  void initState() {
    super.initState();
    final initialTicketPrice =
        context.read<ModifyTicketPriceBloc>().initialTicketPrice;
    // TODO: ticket setup
    // if (initialTicketPrice?.network?.isEmpty == true) {
    //   return;
    // }
    final initialNetwork = context.read<ModifyTicketPriceBloc>().initialNetwork;
    final initialDecimals = initialNetwork?.tokens
            ?.firstWhereOrNull(
              (element) => element.symbol == initialTicketPrice?.currency,
            )
            ?.decimals ??
        1;
    final initialAmount = Web3Utils.formatCryptoCurrency(
      BigInt.parse(initialTicketPrice?.cost ?? '0'),
      currency: '',
      decimals: initialDecimals.toInt(),
    );
    widget.amountController.text = initialAmount;
  }

  void resetAmount() {
    widget.amountController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return GetChainsListBuilder(
      builder: (context, chains) => BlocBuilder<WalletBloc, WalletState>(
        builder: (context, walletState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.event.ticketTierSetting.whatTicketTokenPrice),
              SizedBox(height: Spacing.xSmall),
              BlocBuilder<ModifyTicketPriceBloc, ModifyTicketPriceState>(
                builder: (context, state) => TicketTierFeatureDropdown<Chain?>(
                  value: state.network,
                  placeholder: t.event.ticketTierSetting.selectChain,
                  getDisplayValue: (chain) => chain?.name ?? '',
                  onTap: () => BottomSheetUtils.showSnapBottomSheet(
                    context,
                    builder: (_) => TicketTierFeatureDropdownList<Chain, Chain>(
                      value: state.network,
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
                        resetAmount();
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
                        return TicketTierFeatureDropdown<String>(
                          placeholder: t.event.ticketTierSetting.token,
                          value: state.currency,
                          getDisplayValue: (tokenSymbol) => tokenSymbol ?? '',
                          onTap: () => showCupertinoModalBottomSheet(
                            context: context,
                            expand: true,
                            backgroundColor: LemonColor.atomicBlack,
                            builder: (_) =>
                                TicketTierFeatureDropdownList<String, String>(
                              value: state.currency,
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
                                resetAmount();
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
                          controller: widget.amountController,
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
                const ConnectWalletButton(),
              ],
            ],
          );
        },
      ),
    );
  }
}
