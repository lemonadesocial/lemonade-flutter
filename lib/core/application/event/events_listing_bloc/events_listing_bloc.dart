import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'events_listing_bloc.freezed.dart';

class EventsListingBloc extends Bloc<EventsListingEvent, EventsListingState> {
  final EventService eventService;
  EventsListingBloc(this.eventService) : super(EventsListingState.loading()) {
    on<EventsListingEventFetch>(_onFetch);
    on<EventsListingEventFilter>(_onFilter);
  }

  _onFetch(EventsListingEventFetch blocEvent, Emitter emit) async {
    final listingType = blocEvent.eventListingType ?? EventListingType.all;
    final timeFilterType = blocEvent.eventTimeFilter;
    final userId = blocEvent.userId;
    Either<Failure, List<Event>>? result;

    if (listingType != EventListingType.all && userId == null) {
      emit(EventsListingState.failure());
      return;
    }

    switch (listingType) {
      case EventListingType.all:
        result = await eventService.getHomeEvents();
        break;
      case EventListingType.attending:
        result = await eventService.getEvents(input: GetEventsInput(accepted: userId!));
        break;
      case EventListingType.hosting:
        result = await eventService.getHostingEvents(input: GetHostingEventsInput(id: userId!));
        break;
      default:
        result = await eventService.getHomeEvents();
    }

    result.fold(
      (l) => emit(EventsListingState.failure()),
      (events) => emit(
        EventsListingState.fetched(
          events: events,
          filteredEvents: eventService.filterEventByTime(source: events, selectedFilter: timeFilterType),
        ),
      ),
    );
  }

  _onFilter(EventsListingEventFilter blocEvent, Emitter emit) async {
    final timeFilterType = blocEvent.eventTimeFilter;
    state.whenOrNull(fetched: (events, _) {
      emit(EventsListingState.fetched(
          events: events,
          filteredEvents: eventService.filterEventByTime(source: events, selectedFilter: timeFilterType)));
    });
  }
}

@freezed
class EventsListingState with _$EventsListingState {
  EventsListingState._();

  factory EventsListingState.loading() = EventsListingStateLoading;
  factory EventsListingState.fetched({
    required List<Event> events,
    required List<Event> filteredEvents,
  }) = EventsListingStateFetched;
  factory EventsListingState.failure() = EventsListingStateFailure;
}

@freezed
class EventsListingEvent with _$EventsListingEvent {
  factory EventsListingEvent.fetch({
    EventListingType? eventListingType,
    EventTimeFilter? eventTimeFilter,
    String? userId,
  }) = EventsListingEventFetch;
  factory EventsListingEvent.filter({EventTimeFilter? eventTimeFilter}) = EventsListingEventFilter;
}
