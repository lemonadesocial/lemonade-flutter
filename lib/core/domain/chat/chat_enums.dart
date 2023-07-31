import 'package:matrix/matrix.dart';

enum RoomTypeFilter {
  allChats,
  groups,
  messages,
  spaces;

  static bool Function(Room) getRoomByRoomTypeFilter(RoomTypeFilter filter) {
    switch (filter) {
      case RoomTypeFilter.allChats:
        return (room) => !room.isSpace;
      case RoomTypeFilter.groups:
        return (room) =>
            !room.isSpace && !room.isDirectChat;
      case RoomTypeFilter.messages:
        return (room) =>
            !room.isSpace && room.isDirectChat;
      case RoomTypeFilter.spaces:
        return (r) => r.isSpace;
    }
  }
}