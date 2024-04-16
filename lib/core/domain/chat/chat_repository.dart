import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<GuildRoom>>> getGuildRooms();

  Future<Either<Failure, Guild>> getGuildDetail(num guildId);

  Future<Either<Failure, List<GuildRolePermission>>> getGuildRolePermissions({
    required num guildId,
    required String walletAddress,
  });
}
