import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/event/query/list_event_votings.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_votings_bloc.freezed.dart';

class GetEventVotingsListBloc
    extends Bloc<GetEventVotingsListEvent, GetEventVotingsListState> {
  GetEventVotingsListBloc()
      : super(const GetEventVotingsListState(eventVotings: [])) {
    on<GetEventVotingsListEventFetch>(_onFetch);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onFetch(
    GetEventVotingsListEventFetch event,
    Emitter emit,
  ) async {
    final result = await getIt<EventRepository>().getEventVotings(
      input: Variables$Query$ListEventVotings(
        event: event.eventId,
      ),
    );

    result.fold(
      (failure) => emit(const GetEventVotingsListState(eventVotings: [])),
      (eventVotings) => emit(
        GetEventVotingsListState(
          eventVotings: eventVotings,
        ),
      ),
    );
  }
}

@freezed
class GetEventVotingsListEvent with _$GetEventVotingsListEvent {
  const factory GetEventVotingsListEvent.fetch({
    required String eventId,
  }) = GetEventVotingsListEventFetch;
}

@freezed
class GetEventVotingsListState with _$GetEventVotingsListState {
  const factory GetEventVotingsListState({
    required List<EventVoting> eventVotings,
  }) = GetEventVotingsListStateFetched;
}
