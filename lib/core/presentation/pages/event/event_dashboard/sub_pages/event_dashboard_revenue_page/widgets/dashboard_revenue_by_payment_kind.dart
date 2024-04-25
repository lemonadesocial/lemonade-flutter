import 'package:app/core/domain/cubejs/entities/cube_payment/cube_payment.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_revenue_page/widgets/ticket_revenue_by_currency_item.dart';
import 'package:app/core/utils/cubejs_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EventDashboardRevenueByPaymentKind extends StatelessWidget {
  final Event event;
  final String paymentKindLabel;
  final Widget icon;
  final Map<String, List<CubePaymentMember>> paymentsByCurrency;

  const EventDashboardRevenueByPaymentKind({
    super.key,
    required this.icon,
    required this.event,
    required this.paymentsByCurrency,
    required this.paymentKindLabel,
  });

  int getCurrencyDecimals(String currency) {
    return EventTicketUtils.getCurrencyDecimalsWithPaymentAccounts(
      currency: currency,
      paymentAccounts: event.paymentAccountsExpanded ?? [],
    );
  }

  List<CubePaymentMember> get allPayments {
    return paymentsByCurrency.entries.fold(
      [],
      (previousValue, element) => [...previousValue, ...element.value],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final paymentsByCurrencyEntryList = paymentsByCurrency.entries.toList();
    final totalCount = CubeJsUtils.calculateTotalTicketSold(allPayments);
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizing.medium),
              color: colorScheme.secondaryContainer,
            ),
            child: Center(
              child: icon,
            ),
          ),
          SizedBox(width: Spacing.small),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        paymentKindLabel,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Text(
                      '${totalCount.toInt()} ${t.event.tickets(n: totalCount)}',
                    ),
                  ],
                ),
                SizedBox(height: Spacing.superExtraSmall),
                ...paymentsByCurrencyEntryList.map((entry) {
                  final currency = entry.key;
                  final payments = entry.value;
                  final isLast = paymentsByCurrencyEntryList.indexOf(entry) ==
                      paymentsByCurrencyEntryList.length - 1;
                  return TicketRevenueByCurrencyItem(
                    currency: currency,
                    payments: payments,
                    decimals: getCurrencyDecimals(currency),
                    isLast: isLast,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
