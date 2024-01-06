import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketTierPricingItem extends StatelessWidget {
  const TicketTierPricingItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      children: [
        Container(
          width: Sizing.medium,
          height: Sizing.medium,
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icCash.svg(colorFilter: filter),
            ),
          ),
        ),
        SizedBox(width: Spacing.small),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$50',
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                t.event.ticketTierSetting.creditDebit,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
        ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) =>
              Assets.icons.icMoreHoriz.svg(colorFilter: filter),
        ),
      ],
    );
  }
}
