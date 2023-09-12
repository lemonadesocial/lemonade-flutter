import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_rsvp.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getEvents({
    required GetEventsInput input,
  });

  Future<Either<Failure, List<Event>>> getHomeEvents({
    required GetHomeEventsInput input,
  });

  Future<Either<Failure, List<Event>>> getHostingEvents({
    required GetHostingEventsInput input,
  });

  Future<Either<Failure, Event>> getEventDetail({
    required GetEventDetailInput input,
  });

  Future<Either<Failure, EventRsvp>> acceptEvent({
    required AcceptEventInput input,
  });
}
