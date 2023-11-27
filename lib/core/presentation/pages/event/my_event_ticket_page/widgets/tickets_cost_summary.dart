import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketCostSummary extends StatelessWidget {
  final EventPayment eventPayment;
  final Event event;

  const TicketCostSummary({
    super.key,
    required this.eventPayment,
    required this.event,
  });

  PurchasableTicketType? get selectedTicketType {
    return List.from(event.eventTicketTypes ?? []).firstWhere(
      (item) => item.id == eventPayment.ticketType,
      orElse: () => null,
    );
  }

  double get subTotalValue {
    return (eventPayment.ticketCount ?? 0) *
        (selectedTicketType?.defaultPrice?.fiatCost ?? 0);
  }

  double get totalValue {
    return subTotalValue - (eventPayment.ticketDiscountAmount ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SafeArea(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  height: 1.w,
                  thickness: 1.w,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.medium,
                ),
                child: Center(
                  child: Text(
                    t.event.summary,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  height: 1.w,
                  thickness: 1.w,
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.smMedium),
          // Sub total
          RowInfo(
            title:
                '${eventPayment.ticketCount?.toInt() ?? 0} x ${selectedTicketType?.title}',
            value: NumberUtils.formatCurrency(
              amount: subTotalValue,
              currency: event.currency,
            ),
            textStyle: Typo.extraMedium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          if (eventPayment.ticketDiscountAmount != null) ...[
            SizedBox(height: Spacing.extraSmall),
            RowInfo(
              title:
                  '${t.event.eventOrder.accessCode} (${eventPayment.ticketDiscount})',
              value: NumberUtils.formatCurrency(
                amount: eventPayment.ticketDiscountAmount ?? 0,
                currency: event.currency,
              ),
              textStyle: Typo.extraMedium.copyWith(
                color: LemonColor.accessCodeColor,
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
            child: DottedLine(
              dashColor: colorScheme.outline,
            ),
          ),
          RowInfo(
            title: t.event.eventOrder.total,
            value: NumberUtils.formatCurrency(
              amount: subTotalValue,
              currency: event.currency,
            ),
            textStyle: Typo.extraMedium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class RowInfo extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? textStyle;

  const RowInfo({
    super.key,
    required this.title,
    required this.value,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            title,
            style: textStyle,
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            value,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
