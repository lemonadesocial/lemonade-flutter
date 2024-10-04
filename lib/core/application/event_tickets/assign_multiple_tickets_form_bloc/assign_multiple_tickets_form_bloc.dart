import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'assign_multiple_tickets_form_bloc.freezed.dart';

class AssignMultipleTicketsFormBloc extends Bloc<AssignMultipleTicketsFormEvent,
    AssignMultipleTicketsFormState> {
  AssignMultipleTicketsFormBloc()
      : super(
          AssignMultipleTicketsFormState(
            isValid: false,
            assignees: [],
          ),
        ) {
    on<AssignMultipleTicketsFormEventAdd>(_onAdd);
    on<AssignMultipleTicketsFormEventUpdateItem>(_onUpdateItem);
  }

  void _onAdd(
    AssignMultipleTicketsFormEventAdd event,
    Emitter<AssignMultipleTicketsFormState> emit,
  ) {
    emit(
      state.copyWith(
        assignees: event.assignees,
      ),
    );
  }

  void _onUpdateItem(
    AssignMultipleTicketsFormEventUpdateItem event,
    Emitter<AssignMultipleTicketsFormState> emit,
  ) {
    final assignees = [...state.assignees];
    assignees[event.index] = event.assignee;
    emit(
      _validate(
        state.copyWith(
          assignees: assignees,
        ),
      ),
    );
  }

  AssignMultipleTicketsFormState _validate(
    AssignMultipleTicketsFormState state,
  ) {
    final isValid = state.assignees.every((element) {
      if (element.email == null || element.email?.isEmpty == true) {
        return true;
      }
      return EmailValidator.validate(element.email!);
    });
    return state.copyWith(isValid: isValid);
  }
}

@freezed
class AssignMultipleTicketsFormEvent with _$AssignMultipleTicketsFormEvent {
  factory AssignMultipleTicketsFormEvent.add({
    required List<TicketAssignee> assignees,
  }) = AssignMultipleTicketsFormEventAdd;
  factory AssignMultipleTicketsFormEvent.updateItem({
    required int index,
    required TicketAssignee assignee,
  }) = AssignMultipleTicketsFormEventUpdateItem;
}

@freezed
class AssignMultipleTicketsFormState with _$AssignMultipleTicketsFormState {
  factory AssignMultipleTicketsFormState({
    required bool isValid,
    required List<TicketAssignee> assignees,
  }) = _AssignMultipleTicketsFormState;
}
