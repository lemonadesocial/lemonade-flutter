import 'package:app/core/domain/cubejs/cubejs_enums.dart';
import 'package:app/core/domain/cubejs/entities/cube_payment/cube_payment.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/cubejs_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class EventDashboardRevenueByTicketType extends StatelessWidget {
  final Event event;
  final EventTicketType? eventTicketType;
  final Map<String, List<CubePaymentMember>> paymentsByCurrency;

  const EventDashboardRevenueByTicketType({
    super.key,
    required this.event,
    required this.paymentsByCurrency,
    this.eventTicketType,
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
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            child: SizedBox(
              width: Sizing.medium,
              height: Sizing.medium,
              child: CachedNetworkImage(
                imageUrl: ImageUtils.generateUrl(
                  file: eventTicketType?.photosExpanded?.firstOrNull,
                ),
                placeholder: (_, __) => ImagePlaceholder.ticketThumbnail(
                  backgroundColor: colorScheme.secondaryContainer,
                ),
                errorWidget: (_, __, ___) => ImagePlaceholder.ticketThumbnail(
                  backgroundColor: colorScheme.secondaryContainer,
                ),
                width: Sizing.medium,
                height: Sizing.medium,
                fit: BoxFit.cover,
              ),
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
                        eventTicketType?.title ?? '',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Text(
                      '${CubeJsUtils.calculateTotalTicketSold(allPayments).toString()} ${t.event.eventDashboard.revenue.sold}',
                    ),
                  ],
                ),
                SizedBox(height: Spacing.superExtraSmall),
                ...paymentsByCurrencyEntryList.map((entry) {
                  final currency = entry.key;
                  final payments = entry.value;
                  final isLast = paymentsByCurrencyEntryList.indexOf(entry) ==
                      paymentsByCurrencyEntryList.length - 1;
                  return _TicketRevenueByCurrencyItem(
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

class _TicketRevenueByCurrencyItem extends StatelessWidget {
  final String currency;
  final List<CubePaymentMember> payments;
  final int decimals;
  final bool isLast;
  const _TicketRevenueByCurrencyItem({
    required this.currency,
    required this.payments,
    this.decimals = 0,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isFiat = payments.firstOrNull?.kind == CubePaymentKind.Fiat.name;
    final totalAmount = CubeJsUtils.calculateTotalAmount(payments);
    final totalSoldCount =
        CubeJsUtils.calculateTotalTicketSold(payments).toString();
    final displayedTotalAmount = isFiat
        ? NumberUtils.formatCurrency(
            amount: totalAmount.toDouble(),
            attemptedDecimals: decimals,
            currency: currency,
          )
        : Web3Utils.formatCryptoCurrency(
            totalAmount,
            currency: currency,
            decimals: decimals,
          );

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.superExtraSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text.rich(
            TextSpan(
              text: '$totalSoldCount ${t.event.eventDashboard.revenue.sold}',
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
              children: [
                TextSpan(text: ' ($currency)'),
              ],
            ),
          ),
          Expanded(
            child: DottedLine(
              dashColor: colorScheme.outline,
            ),
          ),
          Text(
            displayedTotalAmount,
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
