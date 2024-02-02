import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/past_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/upcoming_events_listing_bloc.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/pages/event/my_event_tickets_list_page/views/event_reservations_list_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
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
                LemonChip(
                  onTap: () {
                    setState(() {
                      selectedReservationType = ReservationType.upcoming;
                    });
                  },
                  isActive: selectedReservationType == ReservationType.upcoming,
                  label: t.event.upcoming,
                ),
                SizedBox(width: Spacing.superExtraSmall),
                LemonChip(
                  onTap: () {
                    setState(() {
                      selectedReservationType = ReservationType.past;
                    });
                  },
                  isActive: selectedReservationType == ReservationType.past,
                  label: t.event.past,
                ),
              ],
            ),
          ),
          if (selectedReservationType == ReservationType.upcoming)
            BlocBuilder<UpcomingEventsListingBloc, BaseEventsListingState>(
              builder: (context, state) => state.when(
                loading: () => Loading.defaultLoading(context),
                failure: () => EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
                fetched: (eventsList, _) => EventReservationsListView(
                  eventsList: eventsList,
                ),
              ),
            ),
          if (selectedReservationType == ReservationType.past)
            BlocBuilder<PastEventsListingBloc, BaseEventsListingState>(
              builder: (context, state) => state.when(
                loading: () => Loading.defaultLoading(context),
                failure: () => EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
                fetched: (eventsList, _) => EventReservationsListView(
                  eventsList: eventsList,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
