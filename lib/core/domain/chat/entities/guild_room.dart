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
    double? guildId,
    List<double>? guildRoleIds,
    bool? guildRoleRequireAll,
    double? joins,
    String? matrixRoomId,
  }) = _GuildRoom;

  factory GuildRoom.fromJson(Map<String, dynamic> json) =>
      _$GuildRoomFromJson(json);
}
