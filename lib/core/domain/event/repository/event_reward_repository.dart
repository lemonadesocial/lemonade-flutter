import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:dartz/dartz.dart';

abstract class EventRewardRepository {
  Future<Either<Failure, Event>> createEventReward({
    required String eventId,
    required List<Input$EventRewardInput> input,
  });

  Future<Either<Failure, Event>> updateEventReward({
    required String eventId,
    required List<Input$EventRewardInput> input,
  });

  Future<Either<Failure, Event>> deleteEventReward({
    required String eventId,
    required List<Input$EventRewardInput> input,
  });

  Future<Either<Failure, List<EventRewardUse>>> getEventRewardUses({
    required Input$GetEventRewardUsesInput input,
  });

  Future<Either<Failure, bool>> updateEventRewardUse({
    required Input$UpdateEventRewardUseInput input,
  });
}
