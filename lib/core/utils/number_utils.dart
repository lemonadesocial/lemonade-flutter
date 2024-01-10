import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberUtils {
  static String formatCurrency({
    double amount = 0,
    String? currency,
    int attemptedDecimals = 2,
    bool showFree = true,
    String? freeText,
    String? prefix = '',
  }) {
    amount = amount / 100;

    var decimals = amount % 1 == 0 ? attemptedDecimals : 2;

    if (amount == 0 && showFree) {
      return freeText ?? 'free';
    } else {
      var formattedAmount = NumberFormat.currency(
        symbol: NumberFormat.simpleCurrency(name: currency).currencySymbol,
        decimalDigits: decimals,
      ).format(amount);

      return '$prefix$formattedAmount';
    }
  }

  static String formatCompact({
    num? amount,
  }) {
    return NumberFormat.compact().format(amount ?? 0);
  }

  static List<FilteringTextInputFormatter> get currencyInputFormatters => [
        FilteringTextInputFormatter.deny(',', replacementString: '.'),
        FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d*\.?\d*|0\.?\d*')),
      ];

  static double getAmountByDecimals(
    BigInt amount, {
    required int decimals,
  }) {
    return amount / BigInt.from(pow(10, decimals));
  }
}
