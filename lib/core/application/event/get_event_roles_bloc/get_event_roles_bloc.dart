import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_roles_bloc.freezed.dart';

class GetEventRolesBloc extends Bloc<GetEventRolesEvent, GetEventRolesState> {
  final _eventRepository = getIt<EventRepository>();
  GetEventRolesBloc()
      : super(
          GetEventRolesState(
              fetching: true,
              eventRoles: [],
              selectedFilterRole: null,
              searchCriteria: ""),
        ) {
    on<_GetEventRolesEventFetch>(_onFetch);
    on<_GetEventRolesEventSelectFilterRole>(_onselectFilterRole);
    on<_GetEventRolesEventChangeSearchCriteria>(_onChangeSearchCriteria);
  }

  void _onFetch(_GetEventRolesEventFetch event, Emitter emit) async {
    emit(state.copyWith(fetching: true));
    final result = await _eventRepository.getEventRoles();
    result.fold((failure) => emit(state.copyWith(fetching: false)),
        (eventRoles) {
      emit(
        state.copyWith(
          fetching: false,
          eventRoles: eventRoles,
          selectedFilterRole: eventRoles.first,
        ),
      );
    });
  }

  void _onselectFilterRole(
    _GetEventRolesEventSelectFilterRole event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(selectedFilterRole: event.eventRole),
    );
  }

  void _onChangeSearchCriteria(
    _GetEventRolesEventChangeSearchCriteria event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(searchCriteria: event.searchCriteria),
    );
  }
}

@freezed
class GetEventRolesEvent with _$GetEventRolesEvent {
  factory GetEventRolesEvent.fetch() = _GetEventRolesEventFetch;

  factory GetEventRolesEvent.selectFilterRole({
    required EventRole? eventRole,
  }) = _GetEventRolesEventSelectFilterRole;

  factory GetEventRolesEvent.changeSearchCriteria({
    required String? searchCriteria,
  }) = _GetEventRolesEventChangeSearchCriteria;
}

@freezed
class GetEventRolesState with _$GetEventRolesState {
  factory GetEventRolesState({
    required bool fetching,
    required List<EventRole> eventRoles,
    required EventRole? selectedFilterRole,
    required String? searchCriteria,
  }) = _GetEventRolesState;
}
