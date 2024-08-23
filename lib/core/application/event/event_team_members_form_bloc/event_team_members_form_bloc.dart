// import 'package:app/core/domain/event/entities/event_role.dart';
// import 'package:app/core/domain/event/entities/event_user_role.dart';
// import 'package:app/core/domain/event/event_repository.dart';
// import 'package:app/core/domain/user/entities/user.dart';
// import 'package:app/graphql/backend/schema.graphql.dart';
// import 'package:app/injection/register_module.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'event_team_members_form_bloc.freezed.dart';

// class EventTeamMembersFormBloc
//     extends Bloc<EventTeamMembersFormBlocEvent, EventTeamMembersFormBlocState> {
//   final EventUserRole? initialEventUserRole;
//   EventTeamMembersFormBloc({this.initialEventUserRole})
//       : super(
//           EventTeamMembersFormBlocState.initial(),
//         ) {
//     on<EventTeamMembersFormBlocEventSelectRole>(onSelectRole);
//     on<EventTeamMembersFormBlocEventChangeVisibleOnEvent>(
//       onChangeVisibleOnEvent,
//     );
//     on<EventTeamMembersFormBlocEventAddNewUser>(
//       onAddNewUser,
//     );
//     on<EventTeamMembersFormBlocEventAddNewEmail>(
//       onAddNewEmail,
//     );
//     on<EventTeamMembersFormBlocEventRemoveUser>(
//       onRemoveUser,
//     );
//     on<EventTeamMembersFormBlocEventSubmitForm>(
//       onSubmitForm,
//     );
//     on<EventTeamMembersFormBlocEventReset>(
//       onReset,
//     );
//     on<EventTeamMembersFormBlocEventPopulateInitialUserRole>(
//       onPopulateUserRole,
//     );
//     if (initialEventUserRole != null) {
//       add(EventTeamMembersFormBlocEvent.populateInitialUserRole());
//     }
//   }

//   void onSelectRole(
//     EventTeamMembersFormBlocEventSelectRole event,
//     Emitter emit,
//   ) {
//     final isCohost = event.role?.code == Enum$RoleCode.Cohost;
//     final newState = state.copyWith(
//       selectedRole: event.role,
//       visibleOnEvent: isCohost,
//     );
//     emit(
//       _validate(newState),
//     );
//   }

//   void onChangeVisibleOnEvent(
//     EventTeamMembersFormBlocEventChangeVisibleOnEvent event,
//     Emitter emit,
//   ) {
//     final newState = state.copyWith(
//       visibleOnEvent: event.visibleOnEvent,
//     );
//     emit(
//       _validate(newState),
//     );
//   }

//   void onAddNewUser(
//     EventTeamMembersFormBlocEventAddNewUser event,
//     Emitter emit,
//   ) {
//     List<Either<User, String>> newUsers = [
//       ...state.users,
//       Left(event.user),
//     ];
//     emit(
//       _validate(
//         state.copyWith(users: newUsers),
//       ),
//     );
//   }

//   void onAddNewEmail(
//     EventTeamMembersFormBlocEventAddNewEmail event,
//     Emitter emit,
//   ) {
//     List<Either<User, String>> newUsers = [
//       ...state.users,
//       Right(event.email),
//     ];
//     emit(
//       _validate(
//         state.copyWith(users: newUsers),
//       ),
//     );
//   }

//   void onRemoveUser(
//     EventTeamMembersFormBlocEventRemoveUser event,
//     Emitter emit,
//   ) {
//     List<Either<User, String>> newUsers = [...state.users];
//     newUsers.removeAt(event.index);
//     emit(
//       _validate(
//         state.copyWith(users: newUsers),
//       ),
//     );
//   }

//   void onSubmitForm(
//     EventTeamMembersFormBlocEventSubmitForm event,
//     Emitter emit,
//   ) async {
//     emit(state.copyWith(status: EventTeamMembersFormStatus.loading));
//     final List<Input$UserFilter> usersInput = state.users.map((item) {
//       return item.fold(
//         (user) => Input$UserFilter(user_id: user.userId),
//         (email) => Input$UserFilter(email: email),
//       );
//     }).toList();
//     final result = await getIt<EventRepository>().addUserRole(
//       eventId: event.eventId,
//       roles: [
//         Input$RoleInput(
//           visible: state.visibleOnEvent ?? false,
//           role_id: state.selectedRole?.id ?? '',
//         ),
//       ],
//       users: usersInput,
//     );
//     if (result.isLeft()) {
//       return emit(state.copyWith(status: EventTeamMembersFormStatus.error));
//     }
//     return emit(state.copyWith(status: EventTeamMembersFormStatus.success));
//   }

//   void onPopulateUserRole(
//     EventTeamMembersFormBlocEventPopulateInitialUserRole event,
//     Emitter emit,
//   ) {
//     if (initialEventUserRole == null) {
//       return;
//     }
//     emit(
//       _validate(
//         EventTeamMembersFormBlocState(
//           status: EventTeamMembersFormStatus.initial,
//           users: [],
//           selectedRole: null,
//           isValid: false,
//         ),
//       ),
//     );
//   }

//   void onReset(
//     EventTeamMembersFormBlocEventReset event,
//     Emitter emit,
//   ) {
//     emit(EventTeamMembersFormBlocState.initial());
//   }

//   EventTeamMembersFormBlocState _validate(EventTeamMembersFormBlocState state) {
//     final hasSelectedRole = state.selectedRole != null;
//     final isNotEmpty = state.users.isNotEmpty;
//     return state.copyWith(
//       isValid: hasSelectedRole && isNotEmpty,
//     );
//   }
// }

// @freezed
// class EventTeamMembersFormBlocEvent with _$EventTeamMembersFormBlocEvent {
//   factory EventTeamMembersFormBlocEvent.selectRole({
//     EventRole? role,
//   }) = EventTeamMembersFormBlocEventSelectRole;
//   factory EventTeamMembersFormBlocEvent.changeVisibleOnEvent({
//     bool? visibleOnEvent,
//   }) = EventTeamMembersFormBlocEventChangeVisibleOnEvent;
//   factory EventTeamMembersFormBlocEvent.addNewUser({
//     required User user,
//   }) = EventTeamMembersFormBlocEventAddNewUser;
//   factory EventTeamMembersFormBlocEvent.addNewEmail({
//     required String email,
//   }) = EventTeamMembersFormBlocEventAddNewEmail;
//   factory EventTeamMembersFormBlocEvent.removeUser({
//     required int index,
//   }) = EventTeamMembersFormBlocEventRemoveUser;
//   factory EventTeamMembersFormBlocEvent.submitForm({
//     required String eventId,
//   }) = EventTeamMembersFormBlocEventSubmitForm;
//   factory EventTeamMembersFormBlocEvent.populateInitialUserRole() =
//       EventTeamMembersFormBlocEventPopulateInitialUserRole;
//   factory EventTeamMembersFormBlocEvent.reset() =
//       EventTeamMembersFormBlocEventReset;
// }

// @freezed
// class EventTeamMembersFormBlocState with _$EventTeamMembersFormBlocState {
//   factory EventTeamMembersFormBlocState({
//     @Default(EventTeamMembersFormStatus.initial)
//     EventTeamMembersFormStatus status,
//     EventRole? selectedRole,
//     bool? visibleOnEvent,
//     required List<Either<User, String>> users,
//     required bool isValid,
//   }) = _EventTeamMembersFormBlocState;

//   factory EventTeamMembersFormBlocState.initial() =>
//       EventTeamMembersFormBlocState(
//         status: EventTeamMembersFormStatus.initial,
//         users: [],
//         selectedRole: null,
//         visibleOnEvent: true,
//         isValid: false,
//       );
// }

// enum EventTeamMembersFormStatus {
//   initial,
//   loading,
//   success,
//   error,
// }
