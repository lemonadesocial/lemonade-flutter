import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsTicketSummary extends StatelessWidget {
  const EventsTicketSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...[1, 2, 3].map(
          (item) => Container(
            margin: EdgeInsets.only(bottom: Spacing.xSmall),
            child: const TicketSummaryItem(),
          ),
        )
      ],
    );
  }
}

class TicketSummaryItem extends StatelessWidget {
  const TicketSummaryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('2 x  Festival Pass'),
          SizedBox(width: Spacing.extraSmall),
          Container(
            width: 21.w,
            height: 21.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              color: colorScheme.outline,
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: Sizing.small / 2,
                  height: Sizing.small / 2,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            NumberUtils.formatCurrency(
              amount: 10000,
              currency: Currency.USD,
            ),
          )
        ],
      ),
    );
  }
}
