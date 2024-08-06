import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_team_members_form_bloc.freezed.dart';

class EventTeamMembersFormBloc
    extends Bloc<EventTeamMembersFormBlocEvent, EventTeamMembersFormBlocState> {
  EventTeamMembersFormBloc()
      : super(
          EventTeamMembersFormBlocState(
            teamMembers: [],
            isValid: false,
          ),
        ) {
    on<EventTeamMembersFormBlocEventSelectRole>(onSelectRole);
    on<EventTeamMembersFormBlocEventAddNewTeamMember>(
      onAddNewTeamMember,
    );
    on<EventTeamMembersFormBlocEventRemoveTeamMember>(
      onRemoveTeamMember,
    );
  }

  void onSelectRole(
    EventTeamMembersFormBlocEventSelectRole event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      selectedRole: event.role,
    );
    emit(
      _validate(newState),
    );
  }

  void onAddNewTeamMember(
    EventTeamMembersFormBlocEventAddNewTeamMember event,
    Emitter emit,
  ) {
    List<Input$TicketAssignment> newAssignments = [
      ...state.teamMembers,
      Input$TicketAssignment(email: "", count: 1),
    ];

    emit(
      _validate(
        state.copyWith(teamMembers: newAssignments),
      ),
    );
  }

  void onRemoveTeamMember(
    EventTeamMembersFormBlocEventRemoveTeamMember event,
    Emitter emit,
  ) {
    List<Input$TicketAssignment> newAssignments = [...state.teamMembers];
    newAssignments.removeAt(event.index);

    emit(
      _validate(
        state.copyWith(teamMembers: newAssignments),
      ),
    );
  }

  EventTeamMembersFormBlocState _validate(EventTeamMembersFormBlocState state) {
    final hasTicketTypeSelected = state.selectedRole != null;
    final allAssignmentsValid = state.teamMembers
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
class EventTeamMembersFormBlocEvent with _$EventTeamMembersFormBlocEvent {
  factory EventTeamMembersFormBlocEvent.selectRole({
    EventRole? role,
  }) = EventTeamMembersFormBlocEventSelectRole;
  factory EventTeamMembersFormBlocEvent.addNewTeamMember() =
      EventTeamMembersFormBlocEventAddNewTeamMember;
  factory EventTeamMembersFormBlocEvent.removeTeamMember({
    required int index,
  }) = EventTeamMembersFormBlocEventRemoveTeamMember;
}

@freezed
class EventTeamMembersFormBlocState with _$EventTeamMembersFormBlocState {
  factory EventTeamMembersFormBlocState({
    EventRole? selectedRole,
    required List<Input$TicketAssignment> teamMembers,
    required bool isValid,
  }) = _EventTeamMembersFormBlocState;
}
