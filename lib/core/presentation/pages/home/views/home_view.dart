import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/home_events_listing_bloc.dart';
import 'package:app/core/application/event/upcoming_attending_events_bloc/upcoming_attending_events_bloc.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/pages/event/widgets/event_time_filter_button_widget.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/core/presentation/pages/home/views/widgets/pending_invites_card.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        BlocProvider(
          create: (context) => HomeEventListingBloc(
            EventService(getIt<EventRepository>()),
            defaultInput: const GetHomeEventsInput(),
          )..add(
              BaseEventsListingEvent.fetch(),
            ),
        ),
      ],
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  _HomeView({
    super.key,
  });

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  EventTimeFilter? eventTimeFilter;

  void _selectEventTimeFilter(EventTimeFilter? mEventTimeFilter) {
    setState(() {
      eventTimeFilter = mEventTimeFilter;
    });
    context.read<HomeEventListingBloc>().add(
          BaseEventsListingEvent.filter(eventTimeFilter: eventTimeFilter),
        );
  }

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
            sliver: const SliverToBoxAdapter(
              child: PendingInvitesCard(
                count: 6,
              ),
            ),
          ),
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: Spacing.medium,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.discover.discover.toUpperCase(),
                  style: Typo.small.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                EventTimeFilterButton(
                  onSelect: _selectEventTimeFilter,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _EventList<HomeEventListingBloc>(
              eventTimeFilter: eventTimeFilter,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120.h,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventList<T extends BaseEventListingBloc> extends StatelessWidget {
  const _EventList({
    super.key,
    this.eventTimeFilter,
  });
  final EventTimeFilter? eventTimeFilter;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, BaseEventsListingState>(
      builder: (context, eventsListingState) {
        return eventsListingState.when(
          loading: () => Loading.defaultLoading(context),
          fetched: (_, filteredEvents) {
            if (filteredEvents.isEmpty) return _buildEmptyEvents(context);
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => index == filteredEvents.length
                  ? const SizedBox(height: 80)
                  : HomeEventCard(
                      key: Key(filteredEvents[index].id ?? ''),
                      event: filteredEvents[index],
                    ),
              separatorBuilder: (ctx, index) =>
                  SizedBox(height: Spacing.extraSmall),
              itemCount: filteredEvents.length + 1,
            );
          },
          failure: () => Center(
            child: Text(t.common.somethingWrong),
          ),
        );
      },
    );
  }
}
