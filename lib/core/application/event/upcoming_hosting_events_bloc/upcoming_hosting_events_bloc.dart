import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_hosting_events_bloc.freezed.dart';

class UpcomingHostingEventsBloc
    extends Bloc<UpcomingHostingEventsEvent, UpcomingHostingEventsState> {
  final _eventRepository = getIt<EventRepository>();
  final String userId;
  UpcomingHostingEventsBloc({required this.userId})
      : super(UpcomingHostingEventsState.loading()) {
    on<UpcomingHostingEventsEvent>(_onFetch);
  }

  Future<void> _onFetch(UpcomingHostingEventsEvent event, Emitter emit) async {
    if (userId.isEmpty) {
      return emit(UpcomingHostingEventsState.fetched(events: []));
    }
    final result = await _eventRepository.getHostingEvents(
      input: GetHostingEventsInput(
        id: userId,
        skip: 0,
        limit: 100,
      ),
    );
    result.fold(
      (l) => emit(UpcomingHostingEventsState.failure()),
      (events) {
        final now = DateTime.now();
        List<Event> upcomingHostingEvents = events
            .where(
              (event) => event.end?.isAfter(now) ?? false,
            )
            .toList()
          ..sort(
            (a, b) => a.start?.compareTo(b.start ?? DateTime(0)) ?? 0,
          );
        emit(
          UpcomingHostingEventsState.fetched(
            events: upcomingHostingEvents,
          ),
        );
      },
    );
  }
}

@freezed
class UpcomingHostingEventsEvent with _$UpcomingHostingEventsEvent {
  factory UpcomingHostingEventsEvent.fetch() = UpcomingHostingEventsEventFetch;
}

@freezed
class UpcomingHostingEventsState with _$UpcomingHostingEventsState {
  factory UpcomingHostingEventsState.loading() =
      UpcomingHostingEventsStateLoading;
  factory UpcomingHostingEventsState.fetched({
    required List<Event> events,
  }) = UpcomingHostingEventsStateFetched;
  factory UpcomingHostingEventsState.failure() =
      UpcomingHostingEventsStateFailure;
}
