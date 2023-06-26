import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/event/event_query.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EventRepository)
class EventRepositoryImpl implements EventRepository {
  final client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<Event>>> getEvents({
    required GetEventsInput input,
  }) async {
    final result = await client.query<List<Event>>(
      QueryOptions(
        document: getEventsQuery,
        variables: input.toJson(),
        parserFn: (data) => List.from(data['getEvents'])
            .map(
              (item) => Event.fromDto(EventDto.fromJson(item)),
            )
            .toList(),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<Event>>> getHomeEvents({
    required GetHomeEventsInput input
  }) async {
    final result = await client.query<List<Event>>(
      QueryOptions(
        document: getHomeEventsQuery,
        variables: input.toJson(),
        parserFn: (data) => List.from(data['getHomeEvents'])
            .map(
              (item) => Event.fromDto(EventDto.fromJson(item)),
            )
            .toList(),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<Event>>> getHostingEvents({
    required GetHostingEventsInput input,
  }) async {
    final result = await client.query<List<Event>>(
      QueryOptions(
        document: getHostingEventsQuery,
        variables: input.toJson(),
        parserFn: (data) => List.from(data['events'])
            .map(
              (item) => Event.fromDto(EventDto.fromJson(item)),
            )
            .toList(),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }
}
