import 'dart:math';

import 'package:app/core/application/event_tickets/modify_ticket_price_v2_bloc/modify_ticket_price_v2_bloc.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_dropdown.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TicketTierAddStripePriceFormPopup extends StatelessWidget {
  final PaymentAccount eventLevelStripePaymentAccount;
  final TicketPriceInput? initialPriceInput;
  const TicketTierAddStripePriceFormPopup({
    super.key,
    required this.eventLevelStripePaymentAccount,
    this.initialPriceInput,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModifyTicketPriceV2Bloc(
        initialTicketPrice: initialPriceInput,
      ),
      child: _View(
        stripePaymentAccount: eventLevelStripePaymentAccount,
      ),
    );
  }
}

class _View extends StatefulWidget {
  final PaymentAccount stripePaymentAccount;
  const _View({
    required this.stripePaymentAccount,
  });

  @override
  State<_View> createState() => __ViewState();
}

class __ViewState extends State<_View> {
  final defaultCurrency = 'USD';
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final modifyTicketPriceBloc = context.read<ModifyTicketPriceV2Bloc>();
    final initialTicketPrice = modifyTicketPriceBloc.initialTicketPrice;
    final initialCurrency = initialTicketPrice?.currency;
    final initialDecimals = initialCurrency != null
        ? (widget.stripePaymentAccount.accountInfo
                ?.currencyMap?[initialCurrency]?.decimals ??
            0)
        : 0;
    final currencyFormatter = CurrencyTextInputFormatter(
      symbol: '',
      decimalDigits: initialDecimals,
    );
    final initialValue =
        currencyFormatter.format(initialTicketPrice?.cost ?? '');
    amountController.text = initialValue;
    context.read<ModifyTicketPriceV2Bloc>().add(
          ModifyTicketPriceV2Event.onCurrencyChanged(
            currency: initialCurrency ?? defaultCurrency,
          ),
        );
    // }
  }

  void resetAmount() {
    amountController.text = '';
  }

  void onSave() {
    final modifyTicketPriceBloc = context.read<ModifyTicketPriceV2Bloc>();
    final isValid = modifyTicketPriceBloc.state.isValid;
    final currency = modifyTicketPriceBloc.state.currency;
    final cost = modifyTicketPriceBloc.state.cost;
    if (!isValid) {
      return;
    }
    final decimals = (widget.stripePaymentAccount.accountInfo
            ?.currencyMap?[currency ?? '']?.decimals ??
        0);
    final transformedCost =
        (double.parse(cost!) * pow(10, decimals)).toInt().toString();
    Navigator.of(context).pop(
      TicketPriceInput(
        cost: transformedCost,
        currency: modifyTicketPriceBloc.state.currency ?? '',
        paymentAccounts: [widget.stripePaymentAccount.id ?? ''],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final currencies =
        widget.stripePaymentAccount.accountInfo?.currencies ?? [];
    final modifyTicketPriceBloc = context.watch<ModifyTicketPriceV2Bloc>();
    final currency = modifyTicketPriceBloc.state.currency;
    final decimals = currency != null
        ? (widget.stripePaymentAccount.accountInfo?.currencyMap?[currency]
                ?.decimals ??
            0)
        : 0;
    final currencyFormatter = CurrencyTextInputFormatter(
      symbol: '',
      decimalDigits: decimals,
    );
    final isValid = modifyTicketPriceBloc.state.isValid;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetGrabber(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.ticketTierSetting.cardStripe,
                  style: Typo.extraLarge.copyWith(color: colorScheme.onPrimary),
                ),
                Text(
                  t.event.ticketTierSetting.cardStripeDesc,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.smMedium,
                    vertical: Spacing.small,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.06),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                  ),
                  child: Row(
                    children: [
                      Assets.icons.icStripe.svg(
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                      ),
                      SizedBox(width: Spacing.small),
                      Text(
                        t.event.ticketTierSetting.stripe,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        '${widget.stripePaymentAccount.accountInfo?.accountId}',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Spacing.xSmall),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<ModifyTicketPriceV2Bloc,
                          ModifyTicketPriceV2State>(
                        builder: (context, state) => LemonTextField(
                          hintText: t.event.ticketTierSetting.enterPrice,
                          filled: true,
                          fillColor: colorScheme.onPrimary.withOpacity(0.06),
                          controller: amountController,
                          borderColor: colorScheme.outlineVariant,
                          onChange: (value) {
                            context.read<ModifyTicketPriceV2Bloc>().add(
                                  ModifyTicketPriceV2Event.onCostChanged(
                                    cost: currencyFormatter
                                        .getUnformattedValue()
                                        .toString(),
                                  ),
                                );
                          },
                          readOnly: state.currency == null,
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            currencyFormatter,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    BlocBuilder<ModifyTicketPriceV2Bloc,
                        ModifyTicketPriceV2State>(
                      builder: (context, state) {
                        return Expanded(
                          child: TicketTierFeatureDropdown<String?>(
                            value: state.currency,
                            getDisplayValue: (v) => v ?? '',
                            placeholder: t.event.ticketTierSetting.currency,
                            onTap: () => showCupertinoModalBottomSheet(
                              context: context,
                              builder: (innerContext) =>
                                  TicketTierFeatureDropdownList<String, String>(
                                value: state.currency,
                                data: currencies,
                                getDisplayLabel: (v) => v,
                                getValue: (v) => v,
                                onConfirm: (item) {
                                  Navigator.of(innerContext).pop();
                                  context.read<ModifyTicketPriceV2Bloc>().add(
                                        ModifyTicketPriceV2Event
                                            .onCurrencyChanged(
                                          currency: item ?? '',
                                        ),
                                      );
                                  resetAmount();
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: Spacing.medium),
                SafeArea(
                  child: Opacity(
                    opacity: isValid ? 1 : 0.5,
                    child: LinearGradientButton.primaryButton(
                      label: t.common.confirm,
                      onTap: () {
                        if (!isValid) {
                          return;
                        }
                        onSave();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
