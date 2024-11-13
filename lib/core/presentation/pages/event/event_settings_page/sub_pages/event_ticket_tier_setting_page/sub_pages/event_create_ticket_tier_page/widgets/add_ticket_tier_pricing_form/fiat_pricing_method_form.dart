import 'package:app/core/application/event_tickets/modify_ticket_price_bloc/modify_ticket_price_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_dropdown.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FiatPricingMethodForm extends StatefulWidget {
  final PaymentAccount? stripePaymentAccount;
  final TextEditingController amountController;
  const FiatPricingMethodForm({
    super.key,
    this.stripePaymentAccount,
    required this.amountController,
  });

  @override
  State<FiatPricingMethodForm> createState() => _FiatPricingMethodFormState();
}

class _FiatPricingMethodFormState extends State<FiatPricingMethodForm> {
  final defaultCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    final modifyTicketPriceBloc = context.read<ModifyTicketPriceBloc>();
    final initialTicketPrice = modifyTicketPriceBloc.initialTicketPrice;
    if (initialTicketPrice?.network?.isNotEmpty == true) {
      return;
    }
    final initialCurrency = initialTicketPrice?.currency;
    final initialDecimals = initialCurrency != null
        ? (widget.stripePaymentAccount?.accountInfo
                ?.currencyMap?[initialCurrency]?.decimals ??
            0)
        : 0;
    final currencyFormatter = CurrencyTextInputFormatter(
      symbol: '',
      decimalDigits: initialDecimals,
    );
    final initialValue =
        currencyFormatter.format(initialTicketPrice?.cost ?? '');
    widget.amountController.text = initialValue;
    if (widget.stripePaymentAccount != null &&
        modifyTicketPriceBloc.state.currency == null) {
      context.read<ModifyTicketPriceBloc>().add(
            ModifyTicketPriceEvent.onCurrencyChanged(
              currency: defaultCurrency,
            ),
          );
    }
  }

  void resetAmount() {
    widget.amountController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final currencies =
        widget.stripePaymentAccount?.accountInfo?.currencies ?? [];
    final modifyTicketPriceBloc = context.watch<ModifyTicketPriceBloc>();
    final currency = modifyTicketPriceBloc.state.currency;
    final decimals = currency != null
        ? (widget.stripePaymentAccount?.accountInfo?.currencyMap?[currency]
                ?.decimals ??
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
                  child: TicketTierFeatureDropdown<String?>(
                    value: state.currency,
                    getDisplayValue: (v) => v ?? '',
                    placeholder: t.event.ticketTierSetting.currency,
                    onTap: () => showCupertinoModalBottomSheet(
                      context: context,
                      builder: (_) =>
                          TicketTierFeatureDropdownList<String, String>(
                        value: state.currency,
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
                          resetAmount();
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
                  controller: widget.amountController,
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
