import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_team_members_form_bloc.freezed.dart';

class EventTeamMembersFormBloc
    extends Bloc<EventTeamMembersFormBlocEvent, EventTeamMembersFormBlocState> {
  final EventUserRole? initialEventUserRole;
  EventTeamMembersFormBloc({this.initialEventUserRole})
      : super(
          EventTeamMembersFormBlocState.initial(),
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
    on<EventTeamMembersFormBlocEventSubmitForm>(
      onSubmitForm,
    );
    on<EventTeamMembersFormBlocEventPopulateInitialUserRole>(
        onPopulateUserRole);
    if (initialEventUserRole != null) {
      add(EventTeamMembersFormBlocEvent.populateInitialUserRole());
    }
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

  void onSubmitForm(
    EventTeamMembersFormBlocEventSubmitForm event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: EventTeamMembersFormStatus.loading));
    final List<Input$UserFilter> usersInput = state.users
        .map(
          (item) => Input$UserFilter(
            email: item is String ? item : null,
            user_id: item is User ? item.userId : null,
          ),
        )
        .toList();
    final result = await getIt<EventRepository>().addUserRole(
      eventId: event.eventId,
      roles: [
        Input$RoleInput(visible: false, role_id: state.selectedRole?.id ?? ''),
      ],
      users: usersInput,
    );
    if (result.isLeft()) {
      return emit(state.copyWith(status: EventTeamMembersFormStatus.error));
    }
    return emit(state.copyWith(status: EventTeamMembersFormStatus.success));
  }

  void onPopulateUserRole(
    EventTeamMembersFormBlocEventPopulateInitialUserRole event,
    Emitter emit,
  ) {
    if (initialEventUserRole == null) {
      return;
    }
    emit(
      _validate(
        EventTeamMembersFormBlocState(
          users: [],
          selectedRole: null,
          isValid: false,
        ),
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
  factory EventTeamMembersFormBlocEvent.submitForm({
    required String eventId,
  }) = EventTeamMembersFormBlocEventSubmitForm;
  factory EventTeamMembersFormBlocEvent.populateInitialUserRole() =
      EventTeamMembersFormBlocEventPopulateInitialUserRole;
}

@freezed
class EventTeamMembersFormBlocState with _$EventTeamMembersFormBlocState {
  factory EventTeamMembersFormBlocState({
    @Default(EventTeamMembersFormStatus.initial)
    EventTeamMembersFormStatus status,
    EventRole? selectedRole,
    required List<dynamic> users,
    required bool isValid,
  }) = _EventTeamMembersFormBlocState;

  factory EventTeamMembersFormBlocState.initial() =>
      EventTeamMembersFormBlocState(
        status: EventTeamMembersFormStatus.initial,
        users: [],
        isValid: false,
      );
}

enum EventTeamMembersFormStatus {
  initial,
  loading,
  success,
  error,
}
