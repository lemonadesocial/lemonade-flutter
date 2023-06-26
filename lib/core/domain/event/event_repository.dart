import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getEvents();

  Future<Either<Failure, List<Event>>> getHomeEvents(
      {String query = '',
      int limit = 100,
      double latitude = 0,
      double longitude = 0,
      EventTense tense = EventTense.Future});
}
