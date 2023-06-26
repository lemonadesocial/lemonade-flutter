import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/event/event_query.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as:  EventRepository)
class EventRepositoryImpl implements EventRepository {
  final client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    return Right([]);
  }

  @override
  Future<Either<Failure, List<Event>>> getHomeEvents({
    String query = '',
    int limit = 100,
    double latitude = 0,
    double longitude = 0,
    EventTense tense = EventTense.Future,
  }) async {
    final result = await client.query<List<Event>>(
      QueryOptions(
        document: getHomeEventsQuery,
        variables: {
          'query': query,
          'limit': limit,
          'latitude': latitude,
          'longitude': longitude,
          'tense': tense.name,
        },
        parserFn: (data) => List.from(data['getHomeEvents'])
            .map(
              (item) => Event.fromDto(EventDto.fromJson(item)),
            )
            .toList(),
      ),
    );
    print(result.data);
    print(result.parsedData);
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }
}
