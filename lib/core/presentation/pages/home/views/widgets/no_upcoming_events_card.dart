import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';

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
      ? t.event.noUpcomingEventsDescription
      : t.event.noHostedEventsDescription;

  String get buttonLabel => widget.type == NoUpcomingEventsCardType.hosting
      ? t.event.eventCreation.createEvent
      : t.common.actions.explore;

  SvgGenImage get icon => widget.type == NoUpcomingEventsCardType.hosting
      ? Assets.icons.icCalendarGradientLight
      : Assets.icons.icExploreGradient;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          width: 1,
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSvgIcon(
              builder: (colorFilter) => icon.svg(
                width: Sizing.small,
                height: Sizing.small,
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
                    style: Typo.small.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    description,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  LinearGradientButton.secondaryButton(
                    mode: GradientButtonMode.light,
                    label: buttonLabel,
                    height: Sizing.regular,
                    radius: BorderRadius.circular(LemonRadius.small),
                    textStyle: Typo.small.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
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
