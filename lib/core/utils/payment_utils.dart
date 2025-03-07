import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class PaymentUtils {
  static bool isCryptoCurrency(EventCurrency eventCurrency) {
    return eventCurrency.network?.isNotEmpty == true;
  }

  static CurrencyInfo? getCurrencyInfo(
    PaymentAccount? selectedPaymentAccount, {
    required String currency,
  }) {
    if (selectedPaymentAccount?.accountInfo?.currencyMap?.isNotEmpty == true) {
      return selectedPaymentAccount?.accountInfo?.currencyMap?[currency];
    }
    return null;
  }

  static bool isCryptoPayment(EventTicketsPricingInfo? pricingInfo) {
    return (pricingInfo?.paymentAccounts ?? []).isNotEmpty &&
        (pricingInfo?.paymentAccounts?.every(
              (element) => element.type != PaymentAccountType.digital,
            ) ??
            false);
  }

  static List<PaymentAccount> getCommonPaymentAccounts({
    required List<PaymentAccount> accounts1,
    required List<PaymentAccount> accounts2,
  }) {
    return accounts1
        .where(
          (acc1) => accounts2.any((acc2) => acc1.id == acc2.id),
        )
        .toList();
  }

  static String getPaymentStatus(Enum$NewPaymentState? state) {
    return state.toString().split('.').last.replaceAll('_', ' ');
  }
}
