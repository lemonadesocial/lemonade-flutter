import 'package:app/core/domain/payment/payment_enums.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('Please select currency first'),
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
