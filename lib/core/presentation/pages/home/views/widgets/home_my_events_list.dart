import 'package:app/core/application/event/upcoming_attending_events_bloc/upcoming_attending_events_bloc.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/core/presentation/pages/home/views/widgets/no_upcoming_events_card.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

class HomeMyEventsList extends StatelessWidget {
  const HomeMyEventsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appText = context.theme.appTextTheme;
    final state = context.watch<UpcomingAttendingEventsBloc>().state;

    return state.maybeWhen(
      fetched: (events) {
        if (events.isEmpty) {
          return const NoUpcomingEventsCard(
            type: NoUpcomingEventsCardType.attending,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.event.myEvents,
              style: appText.lg,
            ),
            SizedBox(height: Spacing.s4),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
      },
      loading: () => const SizedBox.shrink(),
      failure: () => const SizedBox.shrink(),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
