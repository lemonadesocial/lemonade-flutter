import 'dart:async';

import 'package:app/core/domain/chat/chat_enums.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/stream_extension.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matrix/matrix.dart';

part 'chat_list_bloc.freezed.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final matrixClient = getIt<MatrixService>().client;
  late final StreamSubscription _onSyncSub;

  String? spaceId;

  ChatListBloc({
    this.spaceId,
  }) : super(
          ChatListState(
            channelRooms: [],
            unreadDmRooms: [],
            dmRooms: [],
          ),
        ) {
    _onSyncSub = matrixClient.onSync.stream
        .where((sync) => sync.hasRoomUpdate)
        .rateLimit(
          Duration(seconds: 1),
        )
        .listen((_) {
      add(ChatListEvent.fetchRooms());
    });
    on<ChatListEventFetchRooms>(_onFetchRooms);
  }

  @override
  close() async {
    _onSyncSub.cancel();
    super.close();
  }

  // Event handlers
  _onFetchRooms(ChatListEventFetchRooms event, Emitter emit) async {
    emit(
      state.copyWith(
        channelRooms: List.from(
          matrixClient.rooms
              .where(
                RoomTypeFilter.getRoomByRoomTypeFilter(RoomTypeFilter.groups),
              )
              .toList(),
        ),
        unreadDmRooms: List.from(
          matrixClient.rooms
              .where(
                (room) => RoomTypeFilter.getRoomByRoomTypeFilter(RoomTypeFilter.messages)(room) && room.isUnread,
              )
              .toList(),
        ),
        dmRooms: List.from(
          matrixClient.rooms
              .where(
                (room) => RoomTypeFilter.getRoomByRoomTypeFilter(RoomTypeFilter.messages)(room) && !room.isUnread,
              )
              .toList(),
        ),
      ),
    );
  }
}

@freezed
class ChatListEvent with _$ChatListEvent {
  const factory ChatListEvent.fetchRooms() = ChatListEventFetchRooms;
}

@freezed
class ChatListState with _$ChatListState {
  const factory ChatListState({
    required List<Room> channelRooms,
    required List<Room> dmRooms,
    required List<Room> unreadDmRooms,
  }) = _ChatListState;
}
