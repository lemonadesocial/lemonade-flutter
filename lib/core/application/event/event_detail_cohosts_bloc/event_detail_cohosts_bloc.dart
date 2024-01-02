import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_detail_cohosts_bloc.freezed.dart';

class EventDetailCohostsBloc
    extends Bloc<EventDetailCohostsEvent, EventDetailCohostsState> {
  EventDetailCohostsBloc() : super(const EventDetailCohostsStateLoading()) {
    on<EventDetailCohostsEventFetch>(_onFetch);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onFetch(
    EventDetailCohostsEventFetch event,
    Emitter emit,
  ) async {
    final result = await eventRepository.getEventCohostRequest(
      input: Input$GetEventCohostRequestsInput(event: event.eventId),
    );
    result.fold(
      (failure) => emit(const EventDetailCohostsState.failure()),
      (eventCohostRequests) => emit(
        EventDetailCohostsState.fetched(
          eventCohostRequests: eventCohostRequests,
        ),
      ),
    );
  }
}

@freezed
class EventDetailCohostsEvent with _$EventDetailCohostsEvent {
  const factory EventDetailCohostsEvent.fetch({
    required String eventId,
  }) = EventDetailCohostsEventFetch;
}

@freezed
class EventDetailCohostsState with _$EventDetailCohostsState {
  const factory EventDetailCohostsState.fetched({
    required List<EventCohostRequest> eventCohostRequests,
  }) = EventDetailCohostsStateFetched;
  const factory EventDetailCohostsState.loading() =
      EventDetailCohostsStateLoading;
  const factory EventDetailCohostsState.failure() =
      EventDetailCohostsStateFailure;
}
