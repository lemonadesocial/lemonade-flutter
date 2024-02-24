import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_tickets_bloc.freezed.dart';

class IssueTicketsBloc
    extends Bloc<IssueTicketsBlocEvent, IssueTicketsBlocState> {
  IssueTicketsBloc()
      : super(
          IssueTicketsBlocState(
            ticketAssignments: [
              Input$TicketAssignment(email: '', count: 1),
            ],
            isValid: false,
          ),
        ) {
    on<IssueTicketsBlocEventSelectTicketType>(onSelectTicketType);
    on<IssueTicketsBlocEventUpdateTicketAssignment>(onUpdateTicketAssignment);
    on<IssueTicketsBlocEventAddNewTicketAssignment>(onAddNewTicketAssignment);
    on<IssueTicketsBlocEventRemoveTicketAssignment>(onRemoveTicketAssignment);
  }

  void onSelectTicketType(
    IssueTicketsBlocEventSelectTicketType event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      selectedTicketType: event.ticketType,
    );

    emit(
      _validate(newState),
    );
  }

  void onUpdateTicketAssignment(
    IssueTicketsBlocEventUpdateTicketAssignment event,
    Emitter emit,
  ) {
    final newAssignments = state.ticketAssignments.asMap().entries.map((entry) {
      if (entry.key == event.index) {
        return event.ticketAssignment;
      }
      return entry.value;
    }).toList();

    emit(
      _validate(state.copyWith(ticketAssignments: newAssignments)),
    );
  }

  void onAddNewTicketAssignment(
    IssueTicketsBlocEventAddNewTicketAssignment event,
    Emitter emit,
  ) {
    List<Input$TicketAssignment> newAssignments = [
      ...state.ticketAssignments,
      Input$TicketAssignment(email: "", count: 1),
    ];

    emit(
      _validate(
        state.copyWith(ticketAssignments: newAssignments),
      ),
    );
  }

  void onRemoveTicketAssignment(
    IssueTicketsBlocEventRemoveTicketAssignment event,
    Emitter emit,
  ) {
    List<Input$TicketAssignment> newAssignments = [...state.ticketAssignments];
    newAssignments.removeAt(event.index);

    emit(
      _validate(
        state.copyWith(ticketAssignments: newAssignments),
      ),
    );
  }

  IssueTicketsBlocState _validate(IssueTicketsBlocState state) {
    final hasTicketTypeSelected = state.selectedTicketType != null;
    final allAssignmentsValid = state.ticketAssignments
        .map(
          (assignment) =>
              EmailValidator.validate(assignment.email) && assignment.count > 0,
        )
        .every((element) => element == true);

    return state.copyWith(
      isValid: hasTicketTypeSelected && allAssignmentsValid,
    );
  }
}

@freezed
class IssueTicketsBlocEvent with _$IssueTicketsBlocEvent {
  factory IssueTicketsBlocEvent.selectTicketType({
    EventTicketType? ticketType,
  }) = IssueTicketsBlocEventSelectTicketType;
  factory IssueTicketsBlocEvent.updateTicketAssignment({
    required int index,
    required Input$TicketAssignment ticketAssignment,
  }) = IssueTicketsBlocEventUpdateTicketAssignment;
  factory IssueTicketsBlocEvent.addNewTicketAssignment() =
      IssueTicketsBlocEventAddNewTicketAssignment;
  factory IssueTicketsBlocEvent.removeTicketAssignmen({
    required int index,
  }) = IssueTicketsBlocEventRemoveTicketAssignment;
}

@freezed
class IssueTicketsBlocState with _$IssueTicketsBlocState {
  factory IssueTicketsBlocState({
    EventTicketType? selectedTicketType,
    required List<Input$TicketAssignment> ticketAssignments,
    required bool isValid,
  }) = _IssueTicketsBlocState;
}
