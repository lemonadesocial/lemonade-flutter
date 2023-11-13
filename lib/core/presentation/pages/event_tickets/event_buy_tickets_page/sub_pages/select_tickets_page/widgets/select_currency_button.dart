import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class SelectCurrencyButton extends StatelessWidget {
  final List<Currency> supportedCurrencies;
  final Currency? selectedCurrency;
  final Function(Currency currency)? onSelectCurrency;
  const SelectCurrencyButton({
    super.key,
    required this.supportedCurrencies,
    this.selectedCurrency,
    this.onSelectCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.event.eventBuyTickets.selectCurrency,
          style: Typo.medium.copyWith(color: colorScheme.onSecondary),
        ),
        DropdownButton<Currency>(
          value: selectedCurrency,
          items: supportedCurrencies
              .map(
                (item) => DropdownMenuItem<Currency>(
                  value: item,
                  child: Text(item.name),
                ),
              )
              .toList(),
          onChanged: (currency) {
            if (currency != null) {
              onSelectCurrency?.call(currency);
            }
          },
        ),
      ],
    );
  }
}
