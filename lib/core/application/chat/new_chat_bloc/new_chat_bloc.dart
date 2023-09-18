import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matrix/matrix.dart';

part 'new_chat_bloc.freezed.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final matrixService = getIt<MatrixService>();

  NewChatBloc()
      : super(
          const NewChatState(userSearchResult: null, selectedUsers: []),
        ) {
    on<NewChatEventSearchUsers>(_onSearchUsers);
    on<NewChatEventSelectUser>(_onSelectUser);
    on<NewChatEventDeselectUser>(_onDeselectUser);
  }

  _onSearchUsers(NewChatEventSearchUsers event, Emitter emit) async {
    var text = event.text;
    final result = await matrixService.client.searchUserDirectory(
      text!,
      limit: 20,
    );
    emit(state.copyWith(userSearchResult: result));
  }

  _onSelectUser(NewChatEventSelectUser event, Emitter emit) {
    final selectedUsers = List<String>.from(state.selectedUsers);
    selectedUsers.add(event.userId);
    emit(state.copyWith(selectedUsers: selectedUsers));
  }

  _onDeselectUser(NewChatEventDeselectUser event, Emitter emit) {
    final selectedUsers = List<String>.from(state.selectedUsers);
    selectedUsers.remove(event.userId);
    emit(state.copyWith(selectedUsers: selectedUsers));
  }
}

@freezed
class NewChatEvent with _$NewChatEvent {
  const factory NewChatEvent.searchUsers({
    String? text,
  }) = NewChatEventSearchUsers;

  const factory NewChatEvent.selectUser({
    required String userId,
  }) = NewChatEventSelectUser;

  const factory NewChatEvent.deselectUser({
    required String userId,
  }) = NewChatEventDeselectUser;
}

@freezed
class NewChatState with _$NewChatState {
  const factory NewChatState({
    required SearchUserDirectoryResponse? userSearchResult,
    required List<String> selectedUsers,
  }) = _NewChatState;
}
