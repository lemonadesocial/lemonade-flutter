import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/app_theme/app_theme.dart';

enum NoUpcomingEventsCardType {
  hosting,
  attending,
}

class NoUpcomingEventsCard extends StatefulWidget {
  const NoUpcomingEventsCard({
    super.key,
    required this.type,
  });

  final NoUpcomingEventsCardType type;

  @override
  State<NoUpcomingEventsCard> createState() => _NoUpcomingEventsCardState();
}

class _NoUpcomingEventsCardState extends State<NoUpcomingEventsCard> {
  Translations get t => Translations.of(context);

  String get title => widget.type == NoUpcomingEventsCardType.attending
      ? t.event.noUpcomingEvents
      : t.event.noHostedEvents;

  String get description => widget.type == NoUpcomingEventsCardType.hosting
      ? t.event.noHostedEventsDescription
      : t.event.noUpcomingEventsDescription;

  String get buttonLabel => widget.type == NoUpcomingEventsCardType.hosting
      ? t.event.eventCreation.createEvent
      : t.common.actions.explore;

  SvgGenImage get icon => widget.type == NoUpcomingEventsCardType.hosting
      ? Assets.icons.icCalendarFillGradient
      : Assets.icons.icTicketGradientDark;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(LemonRadius.md),
        border: Border.all(
          width: 1,
          color: appColors.cardBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(Spacing.s3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSvgIcon(
              builder: (colorFilter) => icon.svg(
                width: 40.w,
                height: 40.w,
              ),
            ),
            SizedBox(width: Spacing.small),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: appText.md,
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    description,
                    style: appText.sm.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  LinearGradientButton.secondaryButton(
                    mode: GradientButtonMode.light,
                    label: buttonLabel,
                    height: Sizing.s9,
                    radius: BorderRadius.circular(LemonRadius.sm),
                    onTap: () {
                      if (widget.type == NoUpcomingEventsCardType.hosting) {
                        AutoRouter.of(context).push(
                          CreateEventRoute(),
                        );
                        return;
                      }

                      if (widget.type == NoUpcomingEventsCardType.attending) {
                        AutoRouter.of(context).navigate(
                          DiscoverRoute(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
