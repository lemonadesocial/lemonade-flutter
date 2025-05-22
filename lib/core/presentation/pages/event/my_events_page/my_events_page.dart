import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/past_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/upcoming_events_listing_bloc.dart';
import 'package:app/core/application/event/draft_hosting_events_bloc/draft_hosting_events_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/pages/event/my_events_page/views/my_events_list_view.dart';
import 'package:app/core/presentation/pages/event/my_events_page/widgets/my_events_empty_widget.dart';
import 'package:app/core/presentation/pages/event/my_events_page/widgets/my_events_filter_dropdown.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class MyEventsPage extends StatelessWidget {
  MyEventsPage({super.key});

  final eventService = EventService(getIt<EventRepository>());

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpcomingEventsListingBloc(
            eventService,
            defaultInput: GetUpcomingEventsInput(
              id: userId,
              limit: 100,
              sort: const GetEventSortInput(
                start: 1,
              ),
            ),
          )..add(
              BaseEventsListingEvent.fetch(),
            ),
        ),
        BlocProvider(
          create: (context) => PastEventsListingBloc(
            eventService,
            defaultInput: GetPastEventsInput(
              id: userId,
              limit: 100,
              sort: const GetEventSortInput(
                start: -1,
              ),
            ),
          )..add(
              BaseEventsListingEvent.fetch(),
            ),
        ),
        BlocProvider(
          create: (context) => DraftHostingEventsBloc(userId: userId)
            ..add(const DraftHostingEventsEvent.fetch()),
        ),
      ],
      child: const MyEventsPageView(),
    );
  }
}

class MyEventsPageView extends StatefulWidget {
  const MyEventsPageView({
    super.key,
  });

  @override
  State<MyEventsPageView> createState() => _MyEventsPageViewState();
}

class _MyEventsPageViewState extends State<MyEventsPageView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _hasDraftEvents = false;
  MyEventsFilter _filter = MyEventsFilter.all;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  List<Event> _getFilteredEvents(List<Event> events) {
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (authSession) => authSession.userId,
        );

    switch (_filter) {
      case MyEventsFilter.all:
        return events;
      case MyEventsFilter.hosting:
        return events
            .where(
              (event) =>
                  EventUtils.isOwnEvent(event: event, userId: userId) ||
                  EventUtils.isCohost(
                    event: event,
                    userId: userId,
                  ),
            )
            .toList();
      case MyEventsFilter.attending:
        return events
            .where(
              (event) =>
                  EventUtils.isAttending(
                    event: event,
                    userId: userId,
                  ) &&
                  !EventUtils.isOwnEvent(event: event, userId: userId) &&
                  !EventUtils.isCohost(event: event, userId: userId),
            )
            .toList();
      case MyEventsFilter.pending:
        return events
            .where(
              (event) =>
                  !EventUtils.isAttending(event: event, userId: userId) &&
                  !EventUtils.isOwnEvent(event: event, userId: userId) &&
                  !EventUtils.isCohost(event: event, userId: userId),
            )
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: appColors.pageBg,
      appBar: LemonAppBar(
        backButtonColor: appColors.textTertiary,
        backgroundColor: appColors.pageBg,
        title: t.event.myEvents.capitalize(),
        actions: [
          MyEventsFilterDropdown(
            onChanged: (value) {
              setState(() {
                _filter = value;
              });
            },
            value: _filter,
          ),
          SizedBox(width: Spacing.s4),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelStyle: appText.md,
            unselectedLabelStyle: appText.md.copyWith(
              color: appColors.textTertiary,
            ),
            indicatorColor: appColors.textAccent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: Spacing.s4),
            tabs: <Widget>[
              if (_hasDraftEvents) Tab(text: t.event.draft.capitalize()),
              Tab(text: t.event.upcoming.capitalize()),
              Tab(text: t.event.past.capitalize()),
            ],
          ),
          BlocListener<DraftHostingEventsBloc, DraftHostingEventsState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                fetched: (draftEvents) {
                  if (draftEvents.isNotEmpty) {
                    _tabController.dispose();
                    _tabController = TabController(length: 3, vsync: this);
                    setState(() {
                      _hasDraftEvents = true;
                    });
                  }
                },
              );
            },
            child: Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  if (_hasDraftEvents)
                    BlocBuilder<DraftHostingEventsBloc,
                        DraftHostingEventsState>(
                      builder: (context, state) => state.when(
                        loading: () => Loading.defaultLoading(context),
                        failure: () => EmptyList(
                          emptyText: t.common.somethingWrong,
                        ),
                        fetched: (draftEvents) => MyEventsListView(
                          events: _getFilteredEvents(draftEvents),
                          emptyType: MyEventsEmptyWidgetType.upcoming,
                        ),
                      ),
                    ),
                  BlocBuilder<UpcomingEventsListingBloc,
                      BaseEventsListingState>(
                    builder: (context, state) => state.when(
                      loading: () => Loading.defaultLoading(context),
                      failure: () => EmptyList(
                        emptyText: t.common.somethingWrong,
                      ),
                      fetched: (upcomingEvents, filteredEvents) =>
                          MyEventsListView(
                        events: _getFilteredEvents(upcomingEvents),
                        emptyType: MyEventsEmptyWidgetType.upcoming,
                      ),
                    ),
                  ),
                  BlocBuilder<PastEventsListingBloc, BaseEventsListingState>(
                    builder: (context, state) => state.when(
                      loading: () => Loading.defaultLoading(context),
                      failure: () => EmptyList(
                        emptyText: t.common.somethingWrong,
                      ),
                      fetched: (pastEvents, filteredEvents) => MyEventsListView(
                        events: _getFilteredEvents(pastEvents),
                        emptyType: MyEventsEmptyWidgetType.past,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
