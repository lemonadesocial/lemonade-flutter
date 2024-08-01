import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_cohost_requests_bloc.freezed.dart';

class GetEventCohostRequestsBloc
    extends Bloc<GetEventCohostRequestsEvent, GetEventCohostRequestsState> {
  GetEventCohostRequestsBloc()
      : super(const GetEventCohostRequestsStateLoading()) {
    on<GetEventCohostRequestsEventFetch>(_onFetch);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onFetch(
    GetEventCohostRequestsEventFetch event,
    Emitter emit,
  ) async {
    emit(const GetEventCohostRequestsState.loading());
    final result = await eventRepository.getEventCohostRequest(
      input: Input$GetEventCohostRequestsInput(event: event.eventId),
    );
    result.fold(
      (failure) => emit(const GetEventCohostRequestsState.failure()),
      (eventCohostRequests) => emit(
        GetEventCohostRequestsState.fetched(
          eventCohostRequests: eventCohostRequests,
        ),
      ),
    );
  }
}

@freezed
class GetEventCohostRequestsEvent with _$GetEventCohostRequestsEvent {
  const factory GetEventCohostRequestsEvent.fetch({
    required String eventId,
  }) = GetEventCohostRequestsEventFetch;
}

@freezed
class GetEventCohostRequestsState with _$GetEventCohostRequestsState {
  const factory GetEventCohostRequestsState.fetched({
    required List<EventCohostRequest> eventCohostRequests,
  }) = GetEventCohostRequestsStateFetched;
  const factory GetEventCohostRequestsState.loading() =
      GetEventCohostRequestsStateLoading;
  const factory GetEventCohostRequestsState.failure() =
      GetEventCohostRequestsStateFailure;
}
