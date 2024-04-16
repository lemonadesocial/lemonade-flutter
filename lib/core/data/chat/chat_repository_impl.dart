import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/domain/chat/entities/guild.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/guild_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:app/graphql/backend/chat/query/get_guild_rooms.graphql.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<GuildRoom>>> getGuildRooms() async {
    final result = await _client.query$GetGuildRooms(
      Options$Query$GetGuildRooms(
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    try {
      return Right(
        (result.parsedData?.getGuildRooms ?? [])
            .map(
              (item) => GuildRoom.fromJson(
                item.toJson(),
              ),
            )
            .toList(),
      );
    } catch (e) {
      return const Right([]);
    }
  }

  @override
  Future<Either<Failure, Guild>> getGuildDetail(num guildId) async {
    final result = await GuildUtils.getGuildDetail(guildId);
    try {
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<GuildRolePermission>>> getGuildRolePermissions(
      {required num guildId, required String walletAddress}) async {
    final result =
        await GuildUtils.checkUserAccessToAGuild(guildId, walletAddress);
    try {
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }
}
