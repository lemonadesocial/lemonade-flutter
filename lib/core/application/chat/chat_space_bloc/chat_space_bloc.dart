import 'package:app/core/domain/chat/chat_enums.dart';
import 'package:app/core/service/matrix/matrix_chat_space_extension.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matrix/matrix.dart';

part 'chat_space_bloc.freezed.dart';

class ChatSpaceBloc extends Bloc<ChatSpaceEvent, ChatSpaceState> {
  final matrixService = getIt<MatrixService>();
  ChatSpaceBloc()
      : super(
          const ChatSpaceState(
            spaces: [],
          ),
        ) {
    on<ChatSpaceEventFetchChatSpaces>(_onFetchChatSpaces);
    on<ChatSpaceEventSetActiveSpace>(_onSetActiveSpace);
  }

  _onFetchChatSpaces(ChatSpaceEventFetchChatSpaces event, Emitter emit) async {
    await matrixService.client.roomsLoading;
    await matrixService.client.accountDataLoading;
    var storedActiveSpaceId = await matrixService.getActiveChatSpaceId();
    var activeSpace =
        matrixService.client.getRoomById(storedActiveSpaceId ?? '');

    emit(
      state.copyWith(
        activeSpace: activeSpace,
        spaces: matrixService.client.rooms
            .where(
              RoomTypeFilter.getRoomByRoomTypeFilter(RoomTypeFilter.spaces),
            )
            .toList(),
      ),
    );
  }

  _onSetActiveSpace(ChatSpaceEventSetActiveSpace event, Emitter emit) async {
    var space = event.space;
    // back to root (home)
    await matrixService.setActiveChatSpaceId(space?.id);
    if (space == null) {
      return emit(state.copyWith(activeSpace: null));
    }
    if (!space.isSpace) return;
    emit(state.copyWith(activeSpace: space));
  }
}

@freezed
class ChatSpaceEvent with _$ChatSpaceEvent {
  const factory ChatSpaceEvent.fetchChatSpaces() =
      ChatSpaceEventFetchChatSpaces;
  const factory ChatSpaceEvent.setActiveSpace({
    Room? space,
  }) = ChatSpaceEventSetActiveSpace;
}

@freezed
class ChatSpaceState with _$ChatSpaceState {
  const factory ChatSpaceState({
    Room? activeSpace,
    required List<Room> spaces,
  }) = _ChatSpaceState;
}
