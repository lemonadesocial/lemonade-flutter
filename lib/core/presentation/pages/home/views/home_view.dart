import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/upcoming_attending_events_bloc/upcoming_attending_events_bloc.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpcomingHostingEventsBloc(userId: userId)
            ..add(UpcomingHostingEventsEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => UpcomingAttendingEventsBloc(userId: userId)
            ..add(UpcomingAttendingEventsEvent.fetch()),
        ),
      ],
      child: const HomeViewView(),
    );
  }
}

class HomeViewView extends StatelessWidget {
  const HomeViewView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.small),
            sliver: SliverToBoxAdapter(
              child: Text(
                t.event.hosting.toUpperCase(),
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          BlocBuilder<UpcomingHostingEventsBloc, UpcomingHostingEventsState>(
            builder: (context, state) => state.when(
              loading: () =>
                  SliverToBoxAdapter(child: Loading.defaultLoading(context)),
              failure: () => const SliverToBoxAdapter(
                child: EmptyList(),
              ),
              fetched: (events) {
                return SliverList.separated(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return HomeEventCard(
                      event: events[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: Spacing.large,
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Spacing.medium,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.small),
            sliver: SliverToBoxAdapter(
              child: Text(
                t.event.myEvents.toUpperCase(),
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          BlocBuilder<UpcomingAttendingEventsBloc,
              UpcomingAttendingEventsState>(
            builder: (context, state) => state.when(
              loading: () =>
                  SliverToBoxAdapter(child: Loading.defaultLoading(context)),
              failure: () => const SliverToBoxAdapter(
                child: EmptyList(),
              ),
              fetched: (events) {
                List<Event> upcomingEvents = events
                    .where(
                      (event) =>
                          // Upcoming events
                          !date_utils.DateUtils.isPast(event.start) ||
                          // Current live events
                          (date_utils.DateUtils.isPast(event.start) &&
                              !date_utils.DateUtils.isPast(event.end)),
                    )
                    .toList()
                  ..sort((a, b) => b.start!.compareTo(a.start!));
                return SliverList.separated(
                  itemCount: upcomingEvents.length,
                  itemBuilder: (context, index) {
                    return HomeEventCard(
                      event: upcomingEvents[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: Spacing.large,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
