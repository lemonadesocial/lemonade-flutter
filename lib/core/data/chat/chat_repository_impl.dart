import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
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
    print(">>>>>>>>>>> LOLLL");
    print(result.parsedData?.getGuildRooms);
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
      print("FKING ERROR");
      print(e);
      return const Right([]);
    }
  }
}
