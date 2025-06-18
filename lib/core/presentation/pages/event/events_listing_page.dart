import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/attending_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/home_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/hosting_events_listing_bloc.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/pages/event/widgets/event_card_widget.dart';
import 'package:app/core/presentation/pages/event/widgets/event_time_filter_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
// import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/event/event_service.dart';
// import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventsListingPage extends StatelessWidget {
  final EventListingType? eventListingType;
  const EventsListingPage({
    super.key,
    this.eventListingType,
  });

  HomeEventListingBloc resolveHomeEventsListingBloc() => HomeEventListingBloc(
        EventService(getIt<EventRepository>()),
        defaultInput: const GetHomeEventsInput(),
      );
  AttendingEventListingBloc resolveAttendingEventsListingBloc(String userId) =>
      AttendingEventListingBloc(
        EventService(getIt<EventRepository>()),
        defaultInput: GetEventsInput(accepted: userId),
      );
  HostingEventsListingBloc resolveHostingEventsListingBloc(String userId) =>
      HostingEventsListingBloc(
        EventService(getIt<EventRepository>()),
        defaultInput: GetHostingEventsInput(id: userId),
      );

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
    return _EventsListingView(
      homeEventListingBloc: resolveHomeEventsListingBloc(),
      attendingEventListingBloc: resolveAttendingEventsListingBloc(userId),
      hostingEventsListingBloc: resolveHostingEventsListingBloc(userId),
      eventListingType: eventListingType,
    );
  }
}

class _EventsListingView extends StatefulWidget {
  final EventListingType? eventListingType;

  const _EventsListingView({
    required this.homeEventListingBloc,
    required this.attendingEventListingBloc,
    required this.hostingEventsListingBloc,
    this.eventListingType,
  });
  final HomeEventListingBloc homeEventListingBloc;
  final AttendingEventListingBloc attendingEventListingBloc;
  final HostingEventsListingBloc hostingEventsListingBloc;

  @override
  State<_EventsListingView> createState() => _EventsListingViewState();
}

class _EventsListingViewState extends State<_EventsListingView> {
  EventListingType eventListingType = EventListingType.all;
  EventTimeFilter? eventTimeFilter;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        eventListingType = widget.eventListingType ?? EventListingType.all;
      });
    });
  }

  void _onAuthStateChanged(AuthState authState) {
    authState.maybeWhen(
      unauthenticated: (_) {
        setState(() {
          eventListingType = EventListingType.all;
        });
      },
      orElse: () {},
    );
  }

  void _selectEventListingType(EventListingType mEventListingType) {
    setState(() {
      eventListingType = mEventListingType;
    });
  }

  void _selectEventTimeFilter(EventTimeFilter? mEventTimeFilter) {
    setState(() {
      eventTimeFilter = mEventTimeFilter;
    });
    _selectedEventsBloc
        .add(BaseEventsListingEvent.filter(eventTimeFilter: eventTimeFilter));
  }

  BaseEventListingBloc get _selectedEventsBloc {
    BaseEventListingBloc bloc;
    switch (eventListingType) {
      case EventListingType.all:
        bloc = widget.homeEventListingBloc;
        break;
      case EventListingType.attending:
        bloc = widget.attendingEventListingBloc;
        break;
      case EventListingType.hosting:
        bloc = widget.attendingEventListingBloc;
        break;
    }
    return bloc;
  }

  BaseEventsListingEvent _getInitialEvent(BaseEventListingBloc bloc) {
    return bloc.state.maybeWhen(
      fetched: (events, filteredEvents) {
        return BaseEventsListingEvent.filter(eventTimeFilter: eventTimeFilter);
      },
      orElse: () {
        return BaseEventsListingEvent.fetch(eventTimeFilter: eventTimeFilter);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: t.event.events,
        // TODO: hide chat
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: Spacing.xSmall),
        //     child: GestureDetector(
        //       onTap: () {
        //         Vibrate.feedback(FeedbackType.light);
        //         AutoRouter.of(context).navigateNamed('/chat');
        //       },
        //       child: ThemeSvgIcon(
        //         color: colorScheme.onPrimary,
        //         builder: (filter) => Assets.icons.icChatBubble.svg(
        //           colorFilter: filter,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        child: Column(
          children: [
            SizedBox(height: Spacing.xSmall),
            _buildEventsFilterBar(context),
            SizedBox(height: Spacing.small),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    _selectedEventsBloc.add(
                      BaseEventsListingEvent.fetch(
                        eventTimeFilter: eventTimeFilter,
                      ),
                    );
                  }
                }
                return true;
              },
              child: _buildEventsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsFilterBar(BuildContext ctx) {
    return Row(
      children: [
        LemonChip(
          label: t.event.all,
          isActive: eventListingType == EventListingType.all,
          onTap: () => _selectEventListingType(EventListingType.all),
        ),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, authState) {
            _onAuthStateChanged(authState);
          },
          builder: (context, authState) {
            return authState.maybeWhen(
              authenticated: (_) => Row(
                children: [
                  SizedBox(width: Spacing.superExtraSmall),
                  LemonChip(
                    label: t.event.attending,
                    isActive: eventListingType == EventListingType.attending,
                    onTap: () =>
                        _selectEventListingType(EventListingType.attending),
                  ),
                  SizedBox(width: Spacing.superExtraSmall),
                  LemonChip(
                    label: t.event.hosting,
                    isActive: eventListingType == EventListingType.hosting,
                    onTap: () =>
                        _selectEventListingType(EventListingType.hosting),
                  ),
                ],
              ),
              orElse: SizedBox.shrink,
            );
          },
        ),
        const Spacer(),
        EventTimeFilterButton(
          onSelect: _selectEventTimeFilter,
        ),
      ],
    );
  }

  Widget _buildEventsList() {
    if (eventListingType == EventListingType.attending) {
      return BlocProvider.value(
        value: widget.attendingEventListingBloc
          ..add(_getInitialEvent(widget.attendingEventListingBloc)),
        child: _EventList<AttendingEventListingBloc>(
          eventListingType: eventListingType,
          eventTimeFilter: eventTimeFilter,
        ),
      );
    }

    if (eventListingType == EventListingType.hosting) {
      return BlocProvider.value(
        value: widget.hostingEventsListingBloc
          ..add(_getInitialEvent(widget.hostingEventsListingBloc)),
        child: _EventList<HostingEventsListingBloc>(
          eventListingType: eventListingType,
          eventTimeFilter: eventTimeFilter,
        ),
      );
    }

    return BlocProvider.value(
      value: widget.homeEventListingBloc
        ..add(_getInitialEvent(widget.homeEventListingBloc)),
      child: _EventList<HomeEventListingBloc>(
        eventListingType: eventListingType,
        eventTimeFilter: eventTimeFilter,
      ),
    );
  }
}

class _EventList<T extends BaseEventListingBloc> extends StatelessWidget {
  const _EventList({
    super.key,
    this.eventListingType,
    this.eventTimeFilter,
  });
  final EventListingType? eventListingType;
  final EventTimeFilter? eventTimeFilter;

  Expanded _buildEmptyEvents(BuildContext context) {
    final t = Translations.of(context);
    final String timeFilterText =
        eventTimeFilter != null ? t['common.${eventTimeFilter!.labelKey}'] : '';

    String emptyText;

    switch (eventListingType) {
      case EventListingType.all:
        emptyText = t.event.empty_home_events(time: timeFilterText);
      case EventListingType.attending:
        emptyText = t.event.empty_attending_events(time: timeFilterText);
        break;
      case EventListingType.hosting:
        emptyText = t.event.empty_hosting_events(time: timeFilterText);
        break;
      default:
        emptyText = '';
    }

    return Expanded(
      child: Center(
        child: Text(
          emptyText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, BaseEventsListingState>(
      builder: (context, eventsListingState) {
        return eventsListingState.when(
          loading: () {
            return Expanded(child: Loading.defaultLoading(context));
          },
          fetched: (_, filteredEvents) {
            if (filteredEvents.isEmpty) return _buildEmptyEvents(context);
            return Expanded(
              child: ListView.separated(
                itemBuilder: (ctx, index) => index == filteredEvents.length
                    ? const SizedBox(height: 80)
                    : EventCard(
                        key: Key(filteredEvents[index].id ?? ''),
                        event: filteredEvents[index],
                        onTap: () {
                          AutoRouter.of(context).navigate(
                            EventDetailRoute(
                              eventId: filteredEvents[index].id!,
                            ),
                          );
                        },
                      ),
                separatorBuilder: (ctx, index) =>
                    SizedBox(height: Spacing.extraSmall),
                itemCount: filteredEvents.length + 1,
              ),
            );
          },
          failure: () => Expanded(
            child: Center(
              child: Text(t.common.somethingWrong),
            ),
          ),
        );
      },
    );
  }
}
