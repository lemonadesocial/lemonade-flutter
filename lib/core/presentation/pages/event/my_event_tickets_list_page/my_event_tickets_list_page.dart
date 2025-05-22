import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/past_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/upcoming_events_listing_bloc.dart';
import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/pages/event/my_event_tickets_list_page/views/event_reservations_list_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/backend/event/query/get_past_events.graphql.dart';
import 'package:app/graphql/backend/event/query/get_upcoming_events.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

enum TicketPageMode {
  tickets,
  reservations,
}

enum ReservationType {
  upcoming,
  past,
}

@RoutePage()
class MyEventTicketsListPage extends StatelessWidget {
  MyEventTicketsListPage({
    super.key,
  });

  final eventService = EventService(getIt<EventRepository>());

  @override
  Widget build(BuildContext context) {
    final userId = AuthUtils.getUserId(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpcomingEventsListingBloc(
            eventService,
            defaultInput: GetUpcomingEventsInput(id: userId, limit: 100),
          )..add(BaseEventsListingEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => PastEventsListingBloc(
            eventService,
            defaultInput: GetPastEventsInput(id: userId, limit: 100),
          )..add(BaseEventsListingEvent.fetch()),
        ),
      ],
      child: const MyEventTicketsListView(),
    );
  }
}

class MyEventTicketsListView extends StatefulWidget {
  const MyEventTicketsListView({
    super.key,
  });

  @override
  State<MyEventTicketsListView> createState() => _MyEventTicketsListViewState();
}

class _MyEventTicketsListViewState extends State<MyEventTicketsListView> {
  ReservationType selectedReservationType = ReservationType.upcoming;
  bool upcomingEventsHasNextPage = true;
  bool pastEventsHasNextPage = true;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final userId = AuthUtils.getUserId(context);

    return Scaffold(
      backgroundColor: appColors.pageBg,
      appBar: LemonAppBar(
        title: StringUtils.capitalize(t.event.tickets(n: 2)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.xSmall,
            ),
            child: Row(
              children: [
                LinearGradientButton(
                  onTap: () {
                    setState(() {
                      selectedReservationType = ReservationType.upcoming;
                    });
                  },
                  mode: selectedReservationType == ReservationType.upcoming
                      ? GradientButtonMode.light
                      : GradientButtonMode.tertiary,
                  label: t.event.upcoming,
                  radius: BorderRadius.circular(LemonRadius.full),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                LinearGradientButton(
                  onTap: () {
                    setState(() {
                      selectedReservationType = ReservationType.past;
                    });
                  },
                  mode: selectedReservationType == ReservationType.past
                      ? GradientButtonMode.light
                      : GradientButtonMode.tertiary,
                  label: t.event.past,
                  radius: BorderRadius.circular(LemonRadius.full),
                ),
              ],
            ),
          ),
          if (selectedReservationType == ReservationType.upcoming)
            Query$GetUpcomingEvents$Widget(
              options: Options$Query$GetUpcomingEvents(
                variables: Variables$Query$GetUpcomingEvents(
                  id: userId,
                  limit: 20,
                ),
              ),
              builder: (
                result, {
                fetchMore,
                refetch,
              }) {
                final eventsList = (result.parsedData?.getUpcomingEvents ?? [])
                    .map(
                      (item) => Event.fromDto(
                        EventDto.fromJson(item.toJson()),
                      ),
                    )
                    .toList();
                if (result.isLoading && eventsList.isEmpty) {
                  return Loading.defaultLoading(context);
                }
                if (result.hasException) {
                  return EmptyList(
                    emptyText: t.common.somethingWrong,
                  );
                }
                return EventReservationsListView(
                  eventsList: eventsList,
                  onFetchMore: () {
                    fetchMore?.call(
                      FetchMoreOptions$Query$GetUpcomingEvents(
                        variables: Variables$Query$GetUpcomingEvents(
                          id: userId,
                          limit: 20,
                          skip: eventsList.length,
                        ),
                        updateQuery: (prev, next) {
                          final prevEvents = prev?['getUpcomingEvents'] ?? [];
                          final nextEvents =
                              (next?['getUpcomingEvents'] as List<dynamic>?) ??
                                  [];
                          next?['getUpcomingEvents'] = [
                            ...prevEvents,
                            ...nextEvents,
                          ];
                          if (nextEvents.isEmpty) {
                            setState(() {
                              upcomingEventsHasNextPage = false;
                            });
                          }
                          return next;
                        },
                      ),
                    );
                  },
                );
              },
            ),
          if (selectedReservationType == ReservationType.past)
            Query$GetPastEvents$Widget(
              options: Options$Query$GetPastEvents(
                variables: Variables$Query$GetPastEvents(
                  id: userId,
                  limit: 20,
                  skip: 0,
                ),
              ),
              builder: (
                result, {
                fetchMore,
                refetch,
              }) {
                final eventsList = (result.parsedData?.getPastEvents ?? [])
                    .map(
                      (item) => Event.fromDto(
                        EventDto.fromJson(item.toJson()),
                      ),
                    )
                    .toList();
                if (result.isLoading && eventsList.isEmpty) {
                  return Loading.defaultLoading(context);
                }
                if (result.hasException) {
                  return EmptyList(
                    emptyText: t.common.somethingWrong,
                  );
                }
                return EventReservationsListView(
                  eventsList: eventsList,
                  onFetchMore: () {
                    fetchMore?.call(
                      FetchMoreOptions$Query$GetPastEvents(
                        variables: Variables$Query$GetPastEvents(
                          id: userId,
                          limit: 20,
                          skip: eventsList.length,
                        ),
                        updateQuery: (prev, next) {
                          final prevEvents = prev?['getPastEvents'] ?? [];
                          final nextEvents =
                              (next?['getPastEvents'] as List<dynamic>?) ?? [];
                          next?['getPastEvents'] = [
                            ...prevEvents,
                            ...nextEvents,
                          ];
                          if (nextEvents.isEmpty) {
                            setState(() {
                              pastEventsHasNextPage = false;
                            });
                          }
                          return next;
                        },
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
