import 'package:app/core/application/event/upcoming_attending_events_bloc/upcoming_attending_events_bloc.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMyEventsList extends StatelessWidget {
  const HomeMyEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final state = context.watch<UpcomingAttendingEventsBloc>().state;

    return state.maybeWhen(
      fetched: (events) {
        if (events.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: EdgeInsets.only(top: Spacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.event.myEvents.toUpperCase(),
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Spacing.small),
              ...events.map(
                (event) => Padding(
                  padding: EdgeInsets.only(bottom: Spacing.xSmall),
                  child: HomeEventCard(event: event),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      failure: () => const SizedBox.shrink(),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
