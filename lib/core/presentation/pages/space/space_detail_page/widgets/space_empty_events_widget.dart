import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceNoUpcomingEventsWidget extends StatelessWidget {
  final bool isSubscriber;
  const SpaceNoUpcomingEventsWidget({
    super.key,
    required this.isSubscriber,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;

    return Container(
      padding: EdgeInsets.all(Spacing.s3),
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(LemonRadius.md),
        border: Border.all(
          color: appColors.cardBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThemeSvgIcon(
            color: appColors.textTertiary,
            builder: (filter) => Assets.icons.icDashboard2.svg(
              colorFilter: filter,
              width: Sizing.s10,
              height: Sizing.s10,
            ),
          ),
          SizedBox(
            width: Spacing.s3,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.noUpcomingEvents,
                  style: appText.md,
                ),
                SizedBox(
                  height: Spacing.s1,
                ),
                Text(
                  isSubscriber
                      ? t.space.noUpcomingEventsForSubscriber
                      : t.space.noUpcomingEventsForNonSubscriber,
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpaceEmptyEventsWidget extends StatelessWidget {
  const SpaceEmptyEventsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.s4,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appColors.cardBg,
                  borderRadius: BorderRadius.circular(LemonRadius.full),
                ),
                width: 72.w,
                height: 24.w,
              ),
              SizedBox(width: Spacing.s1_5),
              Container(
                decoration: BoxDecoration(
                  color: appColors.cardBg,
                  borderRadius: BorderRadius.circular(LemonRadius.full),
                ),
                width: 120.w,
                height: 24.w,
              ),
            ],
          ),
          SizedBox(height: Spacing.s2_5),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: Sizing.s16,
              horizontal: Spacing.s12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.md),
              color: appColors.cardBg,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  appColors.cardBg.withOpacity(0.9),
                  appColors.pageBg,
                ],
              ),
            ),
            child: const _UpcomingEmpty(),
          ),
        ],
      ),
    );
  }
}

class _UpcomingEmpty extends StatelessWidget {
  const _UpcomingEmpty();

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ThemeSvgIcon(
          color: appColors.textQuaternary,
          builder: (filter) => Assets.icons.icCalendarMonthSharp.svg(
            colorFilter: filter,
            width: Sizing.s24,
            height: Sizing.s24,
          ),
        ),
        SizedBox(height: Spacing.s6),
        Text(
          t.event.noUpcomingEvents,
          style: appText.lg.copyWith(
            color: appColors.textSecondary,
          ),
        ),
        SizedBox(height: Spacing.s2),
        Text(
          t.event.checkBackLaterForNewEvents,
          style: appText.sm.copyWith(
            color: appColors.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Spacing.s6),
      ],
    );
  }
}
