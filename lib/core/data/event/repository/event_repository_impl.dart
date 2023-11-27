import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/event/dtos/event_rsvp_dto/event_rsvp_dto.dart';
import 'package:app/core/data/event/gql/create_event_mutation.dart';
import 'package:app/core/data/event/gql/event_mutation.dart';
import 'package:app/core/data/event/gql/event_query.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_rsvp.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/core/domain/event/input/create_event_input/create_event_input.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
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
    required GetHomeEventsInput input,
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

  @override
  Future<Either<Failure, Event>> getEventDetail({
    required GetEventDetailInput input,
  }) async {
    final result = await client.query<Event>(
      QueryOptions(
        document: getEventDetailQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => Event.fromDto(
          EventDto.fromJson(data['getEvent']),
        ),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, EventRsvp>> acceptEvent({
    required AcceptEventInput input,
  }) async {
    final result = await client.mutate(
      MutationOptions(
        document: acceptEventMutation,
        variables: input.toJson(),
        parserFn: (data) => EventRsvp.fromDto(
          EventRsvpDto.fromJson(data['acceptEvent']),
        ),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, List<Event>>> getUpcomingEvents({
    required GetUpcomingEventsInput input,
  }) async {
    final result = await client.query<List<Event>>(
      QueryOptions(
        document: getUpcomingEventsQuery,
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

  @override
  Future<Either<Failure, List<Event>>> getPastEvents({
    required GetPastEventsInput input,
  }) async {
    final result = await client.query<List<Event>>(
      QueryOptions(
        document: getPastEventsQuery,
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

  @override
  Future<Either<Failure, Event>> createEvent({
    required CreateEventInput input,
  }) async {
    final result = await client.mutate(
      MutationOptions(
        document: createEventMutation,
        variables: {'input': input.toJson()},
        parserFn: (data) => Event.fromDto(
          EventDto.fromJson(data['createEvent']),
        ),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }
}
