import 'package:app/core/data/event/dtos/event_cohost_request_dto/event_cohost_request_dto.dart';
import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/event/dtos/event_rsvp_dto/event_rsvp_dto.dart';
import 'package:app/core/data/event/gql/event_mutation.dart';
import 'package:app/core/data/event/gql/event_query.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/entities/event_rsvp.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/mutation/create_event.graphql.dart';
import 'package:app/graphql/backend/event/mutation/manage_event_cohost_requests.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event.graphql.dart';
import 'package:app/graphql/backend/event/query/get_event_cohost_requests.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
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
  Future<Either<Failure, Mutation$CreateEvent>> createEvent({
    required Input$EventInput input,
  }) async {
    final result = await client.mutate$CreateEvent(
      Options$Mutation$CreateEvent(
        variables: Variables$Mutation$CreateEvent(input: input),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, Event>> updateEvent({
    required Input$EventInput input,
    required String id,
  }) async {
    final result = await client.mutate$UpdateEvent(
      Options$Mutation$UpdateEvent(
        variables: Variables$Mutation$UpdateEvent(input: input, id: id),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
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
  Future<Either<Failure, List<EventCohostRequest>>> getEventCohostRequest({
    required Input$GetEventCohostRequestsInput input,
  }) async {
    final result = await client.query$GetEventCohostRequests(
      Options$Query$GetEventCohostRequests(
        variables: Variables$Query$GetEventCohostRequests(input: input),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      List.from(
        result.parsedData!.getEventCohostRequests
            .map(
              (item) => EventCohostRequest.fromDto(
                EventCohostRequestDto.fromJson(item.toJson()),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> manageEventCohostRequests({
    required Input$ManageEventCohostRequestsInput input,
  }) async {
    final result = await client.mutate$ManageEventCohostRequests(
      Options$Mutation$ManageEventCohostRequests(
        variables: Variables$Mutation$ManageEventCohostRequests(input: input),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!.manageEventCohostRequests);
  }

  @override
  Future<Either<Failure, bool>> updateEventCheckin({
    required Input$UpdateEventCheckinInput input,
  }) async {
    final result = await client.mutate$UpdateEventCheckin(
      Options$Mutation$UpdateEventCheckin(
        variables: Variables$Mutation$UpdateEventCheckin(input: input),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!.updateEventCheckin);
  }
}
