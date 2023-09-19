import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary/widgets/event_order_slide_to_pay.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventOrderSummaryFooter extends StatelessWidget {
  const EventOrderSummaryFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.smMedium,
        ),
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(
              width: 2.w,
              color: colorScheme.onPrimary.withOpacity(0.06),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Sizing.medium,
                  height: Sizing.medium,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.event.eventPayment.payUsing,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      t.event.eventPayment.cardEnding(lastCardNumber: '4258'),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: Sizing.medium,
                  height: Sizing.medium,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(LemonRadius.normal),
                  ),
                  child: Center(
                    child: ThemeSvgIcon(
                      color: colorScheme.onSurfaceVariant,
                      builder: (filter) => Assets.icons.icEdit.svg(
                        colorFilter: filter,
                        height: Sizing.xSmall,
                        width: Sizing.xSmall,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Spacing.smMedium),
            const EventOrderSlideToPay()
          ],
        ),
      ),
    );
  }
}
