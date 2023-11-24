import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

class PaymentUtils {
  static bool isCryptoCurrency(EventCurrency eventCurrency) {
    return eventCurrency.network != null;
  }

  static CurrencyInfo? getCurrencyInfo(
    EventTicketsPricingInfo? pricingInfo, {
    required Currency currency,
  }) {
    if (pricingInfo?.paymentAccounts?.isNotEmpty == true) {
      return pricingInfo
          ?.paymentAccounts?.first.accountInfo?.currencyMap?[currency];
    }
    return null;
  }
}
