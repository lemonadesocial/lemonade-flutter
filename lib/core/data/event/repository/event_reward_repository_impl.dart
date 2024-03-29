import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/repository/event_reward_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/mutation/update_event.graphql.dart';
import 'package:app/graphql/backend/event/query/get_event_reward_uses.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event_reward_use.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EventRewardRepository)
class EventRewardRepositoryImpl implements EventRewardRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, Event>> createEventReward({
    required String eventId,
    required List<Input$EventRewardInput> input,
  }) async {
    final result = await _client.mutate$UpdateEvent(
      Options$Mutation$UpdateEvent(
        variables: Variables$Mutation$UpdateEvent(
          input: Input$EventInput(
            rewards: input,
          ),
          id: eventId,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      Event.fromDto(
        EventDto.fromJson(
          result.parsedData!.updateEvent.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Event>> deleteEventReward({
    required String eventId,
    required List<Input$EventRewardInput> input,
  }) async {
    final result = await _client.mutate$UpdateEvent(
      Options$Mutation$UpdateEvent(
        variables: Variables$Mutation$UpdateEvent(
          input: Input$EventInput(
            rewards: input,
          ),
          id: eventId,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      Event.fromDto(
        EventDto.fromJson(
          result.parsedData!.updateEvent.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Event>> updateEventReward({
    required String eventId,
    required List<Input$EventRewardInput> input,
  }) async {
    final result = await _client.mutate$UpdateEvent(
      Options$Mutation$UpdateEvent(
        variables: Variables$Mutation$UpdateEvent(
          input: Input$EventInput(
            rewards: input,
          ),
          id: eventId,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      Event.fromDto(
        EventDto.fromJson(
          result.parsedData!.updateEvent.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, List<EventRewardUse>>> getEventRewardUses({
    required Input$GetEventRewardUsesInput input,
  }) async {
    final result = await _client.query$GetEventRewardUses(
      Options$Query$GetEventRewardUses(
        variables: Variables$Query$GetEventRewardUses(input: input),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      List.from(
        result.parsedData!.getEventRewardUses
            .map(
              (item) => EventRewardUse.fromJson(item.toJson()),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> updateEventRewardUse({
    required Input$UpdateEventRewardUseInput input,
  }) async {
    final result = await _client.mutate$UpdateEventRewardUse(
      Options$Mutation$UpdateEventRewardUse(
        variables: Variables$Mutation$UpdateEventRewardUse(input: input),
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(result.parsedData?.updateEventRewardUse ?? false);
  }
}
