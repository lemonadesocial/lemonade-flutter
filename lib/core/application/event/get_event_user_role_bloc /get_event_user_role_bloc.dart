import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_user_role_bloc.freezed.dart';

class GetEventUserRoleBloc
    extends Bloc<GetEventUserRoleEvent, GetEventUserRoleState> {
  GetEventUserRoleBloc() : super(const GetEventUserRoleStateLoading()) {
    on<GetEventUserRoleEventFetch>(_onFetch);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onFetch(
    GetEventUserRoleEventFetch event,
    Emitter emit,
  ) async {
    emit(const GetEventUserRoleState.loading());
    final result = await eventRepository.getEventUserRole(
      eventId: event.eventId,
      userId: event.userId,
    );
    result.fold(
      (failure) => emit(
        const GetEventUserRoleState.fetched(
          eventUserRole: null,
        ),
      ),
      (eventUserRole) => emit(
        GetEventUserRoleState.fetched(
          eventUserRole: eventUserRole,
        ),
      ),
    );
  }
}

@freezed
class GetEventUserRoleEvent with _$GetEventUserRoleEvent {
  const factory GetEventUserRoleEvent.fetch({
    required String eventId,
    required String userId,
  }) = GetEventUserRoleEventFetch;
}

@freezed
class GetEventUserRoleState with _$GetEventUserRoleState {
  const factory GetEventUserRoleState.fetched({
    required EventUserRole? eventUserRole,
  }) = GetEventUserRoleStateFetched;
  const factory GetEventUserRoleState.loading() = GetEventUserRoleStateLoading;
}
