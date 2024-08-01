import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_cohost_requests_bloc.freezed.dart';

class GetEventRolesBloc extends Bloc<GetEventRolesEvent, GetEventRolesState> {
  GetEventRolesBloc() : super(const GetEventRolesStateLoading()) {
    on<GetEventRolesEventFetch>(_onFetch);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onFetch(
    GetEventRolesEventFetch event,
    Emitter emit,
  ) async {
    emit(const GetEventRolesState.loading());
    final result = await eventRepository.getEventRoles();
    result.fold(
      (failure) => emit(const GetEventRolesState.failure()),
      (eventRoles) => emit(
        GetEventRolesState.fetched(
          eventRoles: eventRoles,
        ),
      ),
    );
  }
}

@freezed
class GetEventRolesEvent with _$GetEventRolesEvent {
  const factory GetEventRolesEvent.fetch() = GetEventRolesEventFetch;
}

@freezed
class GetEventRolesState with _$GetEventRolesState {
  const factory GetEventRolesState.fetched({
    required List<EventRole> eventRoles,
  }) = GetEventRolesStateFetched;
  const factory GetEventRolesState.loading() = GetEventRolesStateLoading;
  const factory GetEventRolesState.failure() = GetEventRolesStateFailure;
}
