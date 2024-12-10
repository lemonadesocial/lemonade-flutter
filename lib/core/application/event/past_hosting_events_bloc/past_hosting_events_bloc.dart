import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'past_hosting_events_bloc.freezed.dart';

class PastHostingEventsBloc
    extends Bloc<PastHostingEventsEvent, PastHostingEventsState> {
  final _eventRepository = getIt<EventRepository>();
  final String userId;
  PastHostingEventsBloc({required this.userId})
      : super(PastHostingEventsState.loading()) {
    on<PastHostingEventsEvent>(_onFetch);
  }

  Future<void> _onFetch(PastHostingEventsEvent event, Emitter emit) async {
    if (userId.isEmpty) {
      return emit(PastHostingEventsState.fetched(events: []));
    }
    final result = await _eventRepository.getHostingEvents(
      input: GetHostingEventsInput(
        id: userId,
        skip: 0,
        limit: 50,
        state: const FilterEventInput(
          include: [EventState.ended],
        ),
      ),
    );
    result.fold(
      (l) => emit(PastHostingEventsState.failure()),
      (events) {
        emit(
          PastHostingEventsState.fetched(
            events: events,
          ),
        );
      },
    );
  }
}

@freezed
class PastHostingEventsEvent with _$PastHostingEventsEvent {
  factory PastHostingEventsEvent.fetch() = PastHostingEventsEventFetch;
}

@freezed
class PastHostingEventsState with _$PastHostingEventsState {
  factory PastHostingEventsState.loading() = PastHostingEventsStateLoading;
  factory PastHostingEventsState.fetched({
    required List<Event> events,
  }) = PastHostingEventsStateFetched;
  factory PastHostingEventsState.failure() = PastHostingEventsStateFailure;
}
