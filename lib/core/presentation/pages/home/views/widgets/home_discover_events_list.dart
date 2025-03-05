import 'package:app/core/application/event/events_listing_bloc/home_events_listing_bloc.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDiscoverEventsList extends StatelessWidget {
  final EventTimeFilter? eventTimeFilter;

  const HomeDiscoverEventsList({super.key, this.eventTimeFilter});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final state = context.watch<HomeEventListingBloc>().state;

    return state.when(
      loading: () => const SliverToBoxAdapter(
        child: SizedBox(),
      ),
      fetched: (events, filteredEvents) {
        if (filteredEvents.isEmpty) {
          return SliverToBoxAdapter(child: _buildEmptyEvents(context));
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == filteredEvents.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.medium),
                  child: Loading.defaultLoading(context),
                );
              }
              return Padding(
                padding: EdgeInsets.only(bottom: Spacing.xSmall),
                child: HomeEventCard(
                  key: Key(filteredEvents[index].id ?? ''),
                  event: filteredEvents[index],
                ),
              );
            },
            childCount: filteredEvents.length + 1,
          ),
        );
      },
      failure: () => SliverToBoxAdapter(
        child: Center(child: Text(t.common.somethingWrong)),
      ),
    );
  }

  Widget _buildEmptyEvents(BuildContext context) {
    final t = Translations.of(context);
    final String timeFilterText =
        eventTimeFilter != null ? t['common.${eventTimeFilter!.labelKey}'] : '';

    return Center(
      child: Text(
        t.event.empty_home_events(time: timeFilterText),
        textAlign: TextAlign.center,
      ),
    );
  }
}
