import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_team_members_form_bloc.freezed.dart';

class EventTeamMembersFormBloc
    extends Bloc<EventTeamMembersFormBlocEvent, EventTeamMembersFormBlocState> {
  EventTeamMembersFormBloc()
      : super(
          EventTeamMembersFormBlocState(
            users: [],
            isValid: false,
          ),
        ) {
    on<EventTeamMembersFormBlocEventSelectRole>(onSelectRole);
    on<EventTeamMembersFormBlocEventAddNewUser>(
      onAddNewUser,
    );
    on<EventTeamMembersFormBlocEventAddNewEmail>(
      onAddNewEmail,
    );
    on<EventTeamMembersFormBlocEventRemoveUser>(
      onRemoveUser,
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

  void onAddNewUser(
    EventTeamMembersFormBlocEventAddNewUser event,
    Emitter emit,
  ) {
    List<dynamic> newUsers = [...state.users, event.user];

    emit(
      _validate(
        state.copyWith(users: newUsers),
      ),
    );
  }

  void onAddNewEmail(
    EventTeamMembersFormBlocEventAddNewEmail event,
    Emitter emit,
  ) {
    List<dynamic> newUsers = [...state.users, event.email];

    emit(
      _validate(
        state.copyWith(users: newUsers),
      ),
    );
  }

  void onRemoveUser(
    EventTeamMembersFormBlocEventRemoveUser event,
    Emitter emit,
  ) {
    List<dynamic> newUsers = [...state.users];
    newUsers.removeAt(event.index);

    emit(
      _validate(
        state.copyWith(users: newUsers),
      ),
    );
  }

  EventTeamMembersFormBlocState _validate(EventTeamMembersFormBlocState state) {
    final hasSelectedRole = state.selectedRole != null;
    final isNotEmpty = state.users.isNotEmpty;
    return state.copyWith(
      isValid: hasSelectedRole && isNotEmpty,
    );
  }
}

@freezed
class EventTeamMembersFormBlocEvent with _$EventTeamMembersFormBlocEvent {
  factory EventTeamMembersFormBlocEvent.selectRole({
    EventRole? role,
  }) = EventTeamMembersFormBlocEventSelectRole;
  factory EventTeamMembersFormBlocEvent.addNewUser({
    required User user,
  }) = EventTeamMembersFormBlocEventAddNewUser;
  factory EventTeamMembersFormBlocEvent.addNewEmail({
    required String email,
  }) = EventTeamMembersFormBlocEventAddNewEmail;
  factory EventTeamMembersFormBlocEvent.removeUser({
    required int index,
  }) = EventTeamMembersFormBlocEventRemoveUser;
}

@freezed
class EventTeamMembersFormBlocState with _$EventTeamMembersFormBlocState {
  factory EventTeamMembersFormBlocState({
    EventRole? selectedRole,
    required List<dynamic> users,
    required bool isValid,
  }) = _EventTeamMembersFormBlocState;
}
