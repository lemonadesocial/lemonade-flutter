import 'package:app/core/domain/payment/payment_enums.dart';

class PaymentUtils {
  static bool isBlockchainCurrency(Currency currency) {
    return [
      Currency.ETH,
      Currency.MATIC,
      Currency.USDC,
      Currency.USDT,
      Currency.TCOI,
      Currency.D2COI,
    ].contains(currency);
  }
}
