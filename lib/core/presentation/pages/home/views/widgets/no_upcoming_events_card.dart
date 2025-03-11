import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';

class NoUpcomingEventsCard extends StatelessWidget {
  const NoUpcomingEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.only(top: Spacing.medium),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            width: 1,
            color: colorScheme.outline,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeSvgIcon(
                builder: (colorFilter) => Assets.icons.icExploreGradient.svg(
                  width: Sizing.mSmall,
                  height: Sizing.mSmall,
                ),
              ),
              SizedBox(height: Spacing.small),
              Text(
                t.event.noUpcomingEvents,
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                t.event.noUpcomingEventsDescription,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
