import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_event_cohost_requests_bloc.freezed.dart';

class ManageEventCohostRequestsBloc extends Bloc<ManageEventCohostRequestsEvent,
    ManageEventCohostRequestsState> {
  ManageEventCohostRequestsBloc()
      : super(ManageEventCohostRequestsStateInitial()) {
    on<ManageEventCohostRequestsEventSaveChanged>(_onSaveChanged);
  }
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onSaveChanged(
    ManageEventCohostRequestsEventSaveChanged event,
    Emitter emit,
  ) async {
    emit(ManageEventCohostRequestsState.loading());
    final result = await _eventRepository.manageEventCohostRequests(
      input: Input$ManageEventCohostRequestsInput(
        event: event.eventId,
        decision: event.decision,
        users: event.users,
      ),
    );
    result.fold(
      (failure) => emit(ManageEventCohostRequestsState.failure()),
      (status) {
        emit(ManageEventCohostRequestsState.success());
      },
    );
  }
}

@freezed
class ManageEventCohostRequestsEvent with _$ManageEventCohostRequestsEvent {
  factory ManageEventCohostRequestsEvent.saveChanged({
    required String eventId,
    required List<String> users,
    required bool decision,
  }) = ManageEventCohostRequestsEventSaveChanged;
}

@freezed
class ManageEventCohostRequestsState with _$ManageEventCohostRequestsState {
  factory ManageEventCohostRequestsState.initial() =
      ManageEventCohostRequestsStateInitial;
  factory ManageEventCohostRequestsState.loading() =
      ManageEventCohostRequestsStateLoading;
  factory ManageEventCohostRequestsState.success() =
      ManageEventCohostRequestsStateSuccess;
  factory ManageEventCohostRequestsState.failure() =
      ManageEventCohostRequestsStateFailure;
}
