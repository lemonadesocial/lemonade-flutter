import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NoUpcomingEventsCard extends StatelessWidget {
  const NoUpcomingEventsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: Sizing.s16,
        horizontal: Spacing.s12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.md),
        color: appColors.cardBg,
        border: Border.all(
          color: appColors.cardBorder,
        ),
      ),
      child: const _UpcomingEmpty(),
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
          t.event.myEventsPage.noUpcomingEventsDescription,
          style: appText.sm.copyWith(
            color: appColors.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Spacing.s6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearGradientButton.secondaryButton(
              onTap: () {
                AutoRouter.of(context).push(CreateEventRoute());
              },
              label: t.event.eventCreation.createEvent,
              height: Sizing.s9,
              radius: BorderRadius.circular(LemonRadius.full),
            ),
            SizedBox(width: Spacing.s2),
            LinearGradientButton.tertiaryButton(
              onTap: () {
                AutoRouter.of(context).navigate(DiscoverRoute());
              },
              label: t.common.actions.discover,
              height: Sizing.s9,
              radius: BorderRadius.circular(LemonRadius.full),
            ),
          ],
        ),
      ],
    );
  }
}
