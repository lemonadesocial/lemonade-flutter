import 'package:freezed_annotation/freezed_annotation.dart';

part 'guild_room.freezed.dart';
part 'guild_room.g.dart';

@freezed
class GuildRoom with _$GuildRoom {
  factory GuildRoom({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    String? title,
    num? guildId,
    List<num>? guildRoleIds,
    bool? guildRoleRequireAll,
    num? joins,
    String? matrixRoomId,
  }) = _GuildRoom;

  factory GuildRoom.fromJson(Map<String, dynamic> json) =>
      _$GuildRoomFromJson(json);
}
