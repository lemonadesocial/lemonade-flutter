import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary/widgets/ticket_wave_custom_paint.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventOrderSummary extends StatelessWidget {
  const EventOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraint) => CustomPaint(
              size: Size(constraint.maxWidth, 11.w),
              painter: TicketWaveCustomPaint(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(LemonRadius.normal),
                bottomRight: Radius.circular(LemonRadius.normal),
              ),
            ),
            padding: EdgeInsets.only(
              top: Spacing.medium,
              left: Spacing.medium,
              right: Spacing.medium,
              bottom: Spacing.xSmall,
            ),
            child: Column(
              children: [
                t.event.eventOrder.itemTotal,
                t.event.eventOrder.taxes,
                t.event.eventOrder.convenienceFees
              ]
                  .map(
                    (item) => Container(
                      margin: EdgeInsets.only(bottom: Spacing.xSmall),
                      child: SummaryRow(
                        label: item,
                        value: NumberUtils.formatCurrency(
                          amount: 10000,
                          currency: Currency.USD,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 3.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.medium,
              horizontal: Spacing.medium,
            ),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.normal),
                topRight: Radius.circular(LemonRadius.normal),
              ),
            ),
            child: SummaryRow(
              label: t.event.eventOrder.grandTotal,
              value: NumberUtils.formatCurrency(
                amount: 100000,
                currency: Currency.USD,
              ),
            ),
          ),
          Transform.flip(
            flipY: true,
            child: LayoutBuilder(
              builder: (context, constraint) => CustomPaint(
                size: Size(constraint.maxWidth, 11.w),
                painter: TicketWaveCustomPaint(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Typo.mediumPlus.copyWith(
      color: colorScheme.onSecondary,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textStyle,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.w),
            child: DottedLine(
              dashColor: colorScheme.onPrimary.withOpacity(0.06),
            ),
          ),
        ),
        Text(
          value,
          style: textStyle,
        ),
      ],
    );
  }
}
