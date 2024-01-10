import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_checkins_bloc.freezed.dart';

class GetEventCheckinsBloc
    extends Bloc<GetEventCheckinsEvent, GetEventCheckinsState> {
  GetEventCheckinsBloc() : super(const GetEventCheckinsStateLoading()) {
    on<GetEventCheckinsEventFetch>(_onFetch);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onFetch(
    GetEventCheckinsEventFetch event,
    Emitter emit,
  ) async {
    emit(const GetEventCheckinsState.loading());
    final result = await eventRepository.getEventCheckins(
      input: Input$GetEventCheckinsInput(event: event.eventId),
    );
    result.fold(
      (failure) => emit(const GetEventCheckinsState.failure()),
      (eventCheckins) => emit(
        GetEventCheckinsState.fetched(
          eventCheckins: eventCheckins,
        ),
      ),
    );
  }
}

@freezed
class GetEventCheckinsEvent with _$GetEventCheckinsEvent {
  const factory GetEventCheckinsEvent.fetch({
    required String eventId,
  }) = GetEventCheckinsEventFetch;
}

@freezed
class GetEventCheckinsState with _$GetEventCheckinsState {
  const factory GetEventCheckinsState.fetched({
    required List<EventCheckin> eventCheckins,
  }) = GetEventCheckinsStateFetched;
  const factory GetEventCheckinsState.loading() = GetEventCheckinsStateLoading;
  const factory GetEventCheckinsState.failure() = GetEventCheckinsStateFailure;
}
