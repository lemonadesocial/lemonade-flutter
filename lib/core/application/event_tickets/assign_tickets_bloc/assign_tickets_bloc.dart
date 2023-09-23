import 'package:app/core/data/event/repository/event_ticket_repository_impl.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assign_tickets_bloc.freezed.dart';

class AssignTicketsBloc extends Bloc<AssignTicketsEvent, AssignTicketsState> {
  final Event event;
  final _eventTicketRepository = EventTicketRepositoryImpl();

  AssignTicketsBloc({
    required this.event,
  }) : super(AssignTicketsStateInitial()) {
    on<AssignTicketsEventAssign>(_onAssign);
  }

  Future<void> _onAssign(
    AssignTicketsEventAssign blocEvent,
    Emitter emit,
  ) async {
    emit(AssignTicketsState.loading());

    final result = await _eventTicketRepository.assignTickets(
      input: AssignTicketsInput(
        event: event.id ?? '',
        assignees: blocEvent.assignees,
      ),
    );

    result.fold(
      (l) => emit(AssignTicketsState.failure()),
      (success) => emit(
        AssignTicketsState.success(success: success),
      ),
    );
  }
}

@freezed
class AssignTicketsEvent with _$AssignTicketsEvent {
  factory AssignTicketsEvent.assign({
    required List<TicketAssignee> assignees,
  }) = AssignTicketsEventAssign;
}

@freezed
class AssignTicketsState with _$AssignTicketsState {
  factory AssignTicketsState.initial() = AssignTicketsStateInitial;
  factory AssignTicketsState.loading() = AssignTicketsStateLoading;
  factory AssignTicketsState.success({
    required bool success,
  }) = AssignTicketsStateSuccess;
  factory AssignTicketsState.failure() = AssignTicketsStateFailure;
}
