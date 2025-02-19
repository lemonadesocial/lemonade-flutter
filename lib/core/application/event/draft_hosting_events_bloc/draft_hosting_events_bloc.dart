import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';

part 'draft_hosting_events_bloc.freezed.dart';

class DraftHostingEventsBloc
    extends Bloc<DraftHostingEventsEvent, DraftHostingEventsState> {
  final String userId;
  final _eventRepository = getIt<EventRepository>();

  DraftHostingEventsBloc({required this.userId})
      : super(const DraftHostingEventsState.loading()) {
    on<DraftHostingEventsEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    DraftHostingEventsEventFetch event,
    Emitter<DraftHostingEventsState> emit,
  ) async {
    if (userId.isEmpty) {
      return emit(const DraftHostingEventsState.fetched([]));
    }

    final result = await _eventRepository.getHostingEvents(
      input: GetHostingEventsInput(
        id: userId,
        skip: 0,
        limit: 50,
        draft: true,
      ),
    );

    result.fold(
      (l) => emit(const DraftHostingEventsState.failure()),
      (events) => emit(DraftHostingEventsState.fetched(events)),
    );
  }
}

@freezed
class DraftHostingEventsEvent with _$DraftHostingEventsEvent {
  const factory DraftHostingEventsEvent.fetch() = DraftHostingEventsEventFetch;
}

@freezed
class DraftHostingEventsState with _$DraftHostingEventsState {
  const factory DraftHostingEventsState.loading() =
      DraftHostingEventsStateLoading;
  const factory DraftHostingEventsState.failure() =
      DraftHostingEventsStateFailure;
  const factory DraftHostingEventsState.fetched(List<Event> events) =
      DraftHostingEventsStateFetched;
}
