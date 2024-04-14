import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<GuildRoom>>> getGuildRooms();
}
