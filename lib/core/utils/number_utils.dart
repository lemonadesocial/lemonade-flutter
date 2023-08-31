import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:intl/intl.dart';

class NumberUtils {
  static String formatCurrency({
    double amount = 0,
    Currency? currency,
    int attemptedDecimals = 2,
    bool showFree = true,
    String? freeText,
    String? prefix = '',
  }) {
    amount = amount / 100;


    final decimals = amount % 1 == 0 ? attemptedDecimals : 2;

    if (amount == 0 && showFree) {
      return freeText ?? 'free';
    } else {
      final formattedAmount = NumberFormat.currency(
        symbol: NumberFormat.simpleCurrency(name: currency?.name).currencySymbol,
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
}
