import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/core/presentation/pages/home/views/widgets/no_upcoming_events_card.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/presentation/pages/home/views/widgets/view_more_events_card.dart';

class HomeHostingEventsList extends StatelessWidget {
  const HomeHostingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final state = context.watch<UpcomingHostingEventsBloc>().state;

    return state.maybeWhen(
      fetched: (events) {
        if (events.isEmpty) {
          return const NoUpcomingEventsCard(
            type: NoUpcomingEventsCardType.hosting,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.event.hosting.toUpperCase(),
              style: Typo.small.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Spacing.small),
            ...events.take(2).map(
                  (event) => Padding(
                    padding: EdgeInsets.only(bottom: Spacing.xSmall),
                    child: HomeEventCard(event: event),
                  ),
                ),
            if (events.length > 2)
              Padding(
                padding: EdgeInsets.only(top: Spacing.xSmall),
                child: ViewMoreEventsCard(
                  moreEventsCount: events.length - 2,
                ),
              ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      failure: () => const SizedBox.shrink(),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
