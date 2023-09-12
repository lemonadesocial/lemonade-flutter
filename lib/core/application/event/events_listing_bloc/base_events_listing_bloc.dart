import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_events_listing_bloc.freezed.dart';

abstract class BaseEventListingBloc<I>
    extends Bloc<BaseEventsListingEvent, BaseEventsListingState> {
  final EventService eventService;
  late final PaginationService<Event, I> paginationService =
      PaginationService(getDataFuture: getEvents);
  final I defaultInput;

  BaseEventListingBloc(
    this.eventService, {
    required this.defaultInput,
  }) : super(BaseEventsListingState.loading()) {
    on<BaseEventsListingEventFetch>(_onFetch);
    on<BaseEventsListingEventFilter>(_onFilter);
  }

  Future<Either<Failure, List<Event>>> getEvents(
    int skip,
    bool endReached, {
    required I input,
  });

  _onFetch(BaseEventsListingEventFetch blocEvent, Emitter emit) async {
    final timeFilterType = blocEvent.eventTimeFilter;
    final result = await paginationService.fetch(defaultInput);

    result.fold(
      (l) => emit(BaseEventsListingState.failure()),
      (events) => emit(
        BaseEventsListingState.fetched(
          events: events,
          filteredEvents: eventService.filterEventByTime(
            source: events,
            selectedFilter: timeFilterType,
          ),
        ),
      ),
    );
  }

  _onFilter(BaseEventsListingEventFilter blocEvent, Emitter emit) async {
    final timeFilterType = blocEvent.eventTimeFilter;
    state.whenOrNull(
      fetched: (events, _) {
        emit(
          BaseEventsListingState.fetched(
            events: events,
            filteredEvents: eventService.filterEventByTime(
              source: events,
              selectedFilter: timeFilterType,
            ),
          ),
        );
      },
    );
  }
}

@freezed
class BaseEventsListingState with _$BaseEventsListingState {
  BaseEventsListingState._();

  factory BaseEventsListingState.loading() = BaseEventsListingStateLoading;
  factory BaseEventsListingState.fetched({
    required List<Event> events,
    required List<Event> filteredEvents,
  }) = BaseEventsListingStateFetched;
  factory BaseEventsListingState.failure() = BaseEventsListingStateFailure;
}

@freezed
class BaseEventsListingEvent with _$BaseEventsListingEvent {
  factory BaseEventsListingEvent.fetch({
    EventTimeFilter? eventTimeFilter,
  }) = BaseEventsListingEventFetch;
  factory BaseEventsListingEvent.filter({EventTimeFilter? eventTimeFilter}) =
      BaseEventsListingEventFilter;
}
