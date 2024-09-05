import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_attending_events_bloc.freezed.dart';

class UpcomingAttendingEventsBloc
    extends Bloc<UpcomingAttendingEventsEvent, UpcomingAttendingEventsState> {
  final _eventRepository = getIt<EventRepository>();
  final String userId;
  UpcomingAttendingEventsBloc({required this.userId})
      : super(UpcomingAttendingEventsState.loading()) {
    on<UpcomingAttendingEventsEvent>(_onFetch);
  }
  Future<void> _onFetch(
      UpcomingAttendingEventsEvent event, Emitter emit) async {
    if (userId.isEmpty) {
      return emit(UpcomingAttendingEventsState.fetched(events: []));
    }
    final result = await _eventRepository.getEvents(
      input: GetEventsInput(
        skip: 0,
        limit: 100,
        accepted: userId,
      ),
    );
    result.fold(
      (l) => emit(UpcomingAttendingEventsState.failure()),
      (events) {
        final now = DateTime.now();
        List<Event> upcomingAttendingEvents = events
            .where(
              (event) => event.end?.isAfter(now) ?? false,
            )
            .toList()
          ..sort(
            (a, b) => a.start?.compareTo(b.start ?? DateTime(0)) ?? 0,
          );
        emit(
          UpcomingAttendingEventsState.fetched(
            events: upcomingAttendingEvents,
          ),
        );
      },
    );
  }
}

@freezed
class UpcomingAttendingEventsEvent with _$UpcomingAttendingEventsEvent {
  factory UpcomingAttendingEventsEvent.fetch() =
      UpcomingAttendingEventsEventFetch;
}

@freezed
class UpcomingAttendingEventsState with _$UpcomingAttendingEventsState {
  factory UpcomingAttendingEventsState.loading() =
      UpcomingAttendingEventsStateLoading;
  factory UpcomingAttendingEventsState.fetched({
    required List<Event> events,
  }) = UpcomingAttendingEventsStateFetched;
  factory UpcomingAttendingEventsState.failure() =
      UpcomingAttendingEventsStateFailure;
}
