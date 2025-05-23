import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/core/presentation/pages/home/views/widgets/no_upcoming_events_card.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeMyEventsList extends StatelessWidget {
  final List<Event> events;

  const HomeMyEventsList({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: InkWell(
            onTap: () {
              AutoRouter.of(context).push(MyEventsRoute());
            },
            child: Row(
              children: [
                Text(
                  t.event.homeUpcomingEvents,
                  style: appText.lg,
                ),
                const Spacer(),
                ThemeSvgIcon(
                  color: appColors.textQuaternary,
                  builder: (filter) => Assets.icons.icArrowForward.svg(
                    width: Sizing.s6,
                    height: Sizing.s6,
                    colorFilter: filter,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.s4,
          ),
        ),
        if (events.isEmpty)
          const SliverToBoxAdapter(
            child: NoUpcomingEventsCard(),
          ),
        if (events.isNotEmpty)
          SliverList.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.xSmall,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return HomeEventCard(event: event);
            },
          ),
      ],
    );
  }
}
