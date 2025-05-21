import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/core/presentation/pages/home/views/widgets/no_upcoming_events_card.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/presentation/pages/home/views/widgets/view_more_events_card.dart';

class HomeHostingEventsList extends StatelessWidget {
  const HomeHostingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final state = context.watch<UpcomingHostingEventsBloc>().state;
    final appTextTheme = Theme.of(context).appTextTheme;

    return state.maybeWhen(
      fetched: (events) {
        if (events.isEmpty) {
          return const NoUpcomingEventsCard(
            type: NoUpcomingEventsCardType.hosting,
          );
        }

        final eventsList = events.take(2).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.event.hosting.capitalize(),
              style: appTextTheme.lg,
            ),
            SizedBox(height: Spacing.s4),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: Spacing.xSmall,
              ),
              itemCount: eventsList.length,
              itemBuilder: (context, index) {
                final event = eventsList[index];
                return HomeEventCard(event: event);
              },
            ),
            if (events.length > 2) ...[
              SizedBox(height: Spacing.xSmall),
              ViewMoreEventsCard(
                moreEventsCount: events.length - 2,
              ),
            ],
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      failure: () => const SizedBox.shrink(),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
