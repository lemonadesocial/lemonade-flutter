import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/events_listing_bloc.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/core/presentation/pages/event/widgets/event_card_widget.dart';
import 'package:app/core/presentation/pages/event/widgets/event_time_filter_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventsListingPage extends StatelessWidget {
  late final EventService eventService = EventService(getIt<EventRepository>());

  Widget _eventsListingBlocProvider(Widget child) {
    return BlocProvider<EventsListingBloc>(
      create: (context) => EventsListingBloc(eventService)..add(EventsListingEvent.fetch()),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _eventsListingBlocProvider(
      _EventsListingView(),
    );
  }
}

class _EventsListingView extends StatefulWidget {
  const _EventsListingView();

  @override
  State<_EventsListingView> createState() => _EventsListingViewState();
}

class _EventsListingViewState extends State<_EventsListingView> {
  EventListingType eventListingType = EventListingType.all;
  EventTimeFilter? eventTimeFilter;

  _selectEventListingType(EventListingType _eventListingType) {
    final userId = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (session) => session.userId,
          orElse: () => null,
        );
    setState(() {
      eventListingType = _eventListingType;
    });
    context.read<EventsListingBloc>().add(
          EventsListingEvent.fetch(
            eventListingType: _eventListingType,
            eventTimeFilter: eventTimeFilter,
            userId: userId,
          ),
        );
  }

  _selectEventTimeFilter(EventTimeFilter? _eventTimeFilter) {
    setState(() {
      eventTimeFilter = _eventTimeFilter;
    });
    context.read<EventsListingBloc>().add(EventsListingEvent.filter(eventTimeFilter: eventTimeFilter));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.event.events),
        leading: const Icon(Icons.menu_rounded),
        actions: [
          ThemeSvgIcon(color: themeColor.onSurface, builder: (filter) => Assets.icons.icChat.svg(colorFilter: filter)),
          SizedBox(width: Spacing.medium),
        ],
      ),
      backgroundColor: themeColor.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        child: Column(
          children: [
            SizedBox(height: Spacing.xSmall),
            _buildEventsFilterBar(context),
            SizedBox(height: Spacing.small),
            // _buildEventsListing(),
            _buildEventsListing()
          ],
        ),
      ),
    );
  }

  Widget _buildEventsFilterBar(BuildContext ctx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LemonChip(
          label: t.event.all,
          isActive: eventListingType == EventListingType.all,
          onTap: () => _selectEventListingType(EventListingType.all),
        ),
        BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
          return authState.maybeWhen(
              authenticated: (_) => Row(
                    children: [
                      SizedBox(width: Spacing.superExtraSmall),
                      LemonChip(
                        label: t.event.attending,
                        isActive: eventListingType == EventListingType.attending,
                        onTap: () => _selectEventListingType(EventListingType.attending),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      LemonChip(
                        label: t.event.hosting,
                        isActive: eventListingType == EventListingType.hosting,
                        onTap: () => _selectEventListingType(EventListingType.hosting),
                      ),
                    ],
                  ),
              orElse: () => SizedBox.shrink());
        }),
        const Spacer(),
        EventTimeFilterButton(
          onSelect: (filter) => _selectEventTimeFilter(filter),
        ),
      ],
    );
  }

  _buildEventsListing() {
    return BlocBuilder<EventsListingBloc, EventsListingState>(
      builder: (context, eventsListingState) {
        final colorScheme = Theme.of(context).colorScheme;
        return eventsListingState.when(
          loading: () {
            return Expanded(
                child: Center(
              child: CupertinoActivityIndicator(color: colorScheme.onSecondary),
            ));
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
                      ),
                separatorBuilder: (ctx, index) => SizedBox(height: Spacing.extraSmall),
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

  _buildEmptyEvents(BuildContext context) {
    final t = Translations.of(context);
    String timeFilterText = eventTimeFilter != null ? t['common.${eventTimeFilter!.labelKey}'] : '';

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
        child: Text(emptyText, textAlign: TextAlign.center,),
      ),
    );
  }
}
