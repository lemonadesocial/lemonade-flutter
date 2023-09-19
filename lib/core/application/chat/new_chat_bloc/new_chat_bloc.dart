import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:matrix/matrix.dart';
import 'package:matrix/matrix.dart' as sdk;

part 'new_chat_bloc.freezed.dart';

@lazySingleton
class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final matrixService = getIt<MatrixService>();

  NewChatBloc()
      : super(
          const NewChatState(
              userSearchResult: null,
              selectedUsers: [],
              isSearching: false,
              isCreating: false,
              createdRoomId: null),
        ) {
    on<NewChatEventSearchUsers>(_onSearchUsers);
    on<NewChatEventSelectUser>(_onSelectUser);
    on<NewChatEventDeselectUser>(_onDeselectUser);
    on<NewChatEventStartChat>(_onStartChat);
  }

  _onSearchUsers(NewChatEventSearchUsers event, Emitter emit) async {
    emit(state.copyWith(isSearching: true));
    var text = event.text;
    try {
      final result = await matrixService.client.searchUserDirectory(
        text!,
        limit: 20,
      );
      emit(
        state.copyWith(
          isSearching: false,
          userSearchResult: result,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isSearching: false));
    }
  }

  _onSelectUser(NewChatEventSelectUser event, Emitter emit) {
    final selectedUsers = List<Profile>.from(state.selectedUsers);
    selectedUsers.add(event.user);
    emit(state.copyWith(selectedUsers: selectedUsers));
  }

  _onDeselectUser(NewChatEventDeselectUser event, Emitter emit) {
    final selectedUsers = List<Profile>.from(state.selectedUsers);
    selectedUsers.remove(event.user);
    emit(state.copyWith(selectedUsers: selectedUsers));
  }

  _onStartChat(NewChatEventStartChat event, Emitter emit) async {
    emit(
      state.copyWith(isCreating: true),
    );
    final List<String> selectedUserIds =
        state.selectedUsers.map((profile) => profile.userId).toList();
    // Create direct 1 vs 1 chat
    if (selectedUserIds.length == 1) {
      final roomId = await matrixService.client.startDirectChat(
        state.selectedUsers[0].userId,
      );
      emit(
        state.copyWith(
          createdRoomId: roomId,
          isCreating: false,
        ),
      );
      return;
    }
    // Create group chat
    final roomId = await matrixService.client.createGroupChat(
      visibility: sdk.Visibility.private,
      preset: sdk.CreateRoomPreset.privateChat,
      invite: selectedUserIds,
    );
    await matrixService.client.joinRoom(roomId);
    emit(
      state.copyWith(
        createdRoomId: roomId,
        isCreating: false,
      ),
    );
    // final roomID = await showFutureLoadingDialog<String>(
    //   context: context,
    //   future: () => matrixService.client.startDirectChat(
    //     context.read<NewChatBloc>().state.selectedUsers[0].userId,
    //   ),
    // );
    // if (roomID.error == null) {
    //   AutoRouter.of(context).navigateNamed('/chat/detail/${roomID.result}');
    //   await Future.delayed(const Duration(milliseconds: 400));
    //   Navigator.of(context).pop();
    //   return;
    // }
    // Group chat
    // final roomID = await showFutureLoadingDialog(
    //   context: context,
    //   future: () async {
    //     final roomId = await matrixService.client.createGroupChat(
    //       visibility: sdk.Visibility.private,
    //       preset: sdk.CreateRoomPreset.privateChat,
    //       invite: selectedUserIds,
    //     );
    //     await matrixService.client.joinRoom(roomId);
    //     return roomId;
    //   },
    // );
    // if (roomID.error == null) {
    //   AutoRouter.of(context).navigateNamed('/chat/detail/${roomID.result}');
    //   await Future.delayed(const Duration(milliseconds: 400));
    //   Navigator.of(context).pop();
    // }
  }
}

@freezed
class NewChatEvent with _$NewChatEvent {
  const factory NewChatEvent.searchUsers({
    String? text,
  }) = NewChatEventSearchUsers;

  const factory NewChatEvent.selectUser({
    required Profile user,
  }) = NewChatEventSelectUser;

  const factory NewChatEvent.deselectUser({
    required Profile user,
  }) = NewChatEventDeselectUser;

  const factory NewChatEvent.startChat() = NewChatEventStartChat;
}

@freezed
class NewChatState with _$NewChatState {
  const factory NewChatState({
    required SearchUserDirectoryResponse? userSearchResult,
    required List<Profile> selectedUsers,
    required bool isSearching,
    required bool isCreating,
    required String? createdRoomId,
  }) = _NewChatState;
}
