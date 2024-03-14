import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_accepted_export.dart';
import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/entities/event_rsvp.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/event/mutation/create_event.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:dartz/dartz.dart';
import 'package:app/graphql/backend/event/query/get_event_join_request.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

  Future<Either<Failure, List<Event>>> getUpcomingEvents({
    required GetUpcomingEventsInput input,
  });

  Future<Either<Failure, List<Event>>> getPastEvents({
    required GetPastEventsInput input,
  });

  Future<Either<Failure, Event>> getEventDetail({
    required GetEventDetailInput input,
  });

  Future<Either<Failure, EventRsvp>> acceptEvent({
    required AcceptEventInput input,
  });

  Future<Either<Failure, Mutation$CreateEvent>> createEvent({
    required Input$EventInput input,
  });

  Future<Either<Failure, Event>> updateEvent({
    required Input$EventInput input,
    required String id,
  });

  Future<Either<Failure, List<EventCohostRequest>>> getEventCohostRequest({
    required Input$GetEventCohostRequestsInput input,
  });

  Future<Either<Failure, bool>> manageEventCohostRequests({
    required Input$ManageEventCohostRequestsInput input,
  });

  Future<Either<Failure, bool>> updateEventCheckin({
    required Input$UpdateEventCheckinInput input,
  });

  Future<Either<Failure, List<EventCheckin>>> getEventCheckins({
    required Input$GetEventCheckinsInput input,
  });

  Future<Either<Failure, List<EventJoinRequest>>> getEventJoinRequests({
    required Variables$Query$GetEventJoinRequests input,
  });

  Future<Either<Failure, EventJoinRequest>> getEventJoinRequest({
    required Variables$Query$GetEventJoinRequest input,
    FetchPolicy? fetchPolicy,
  });

  Future<Either<Failure, EventJoinRequest?>> getMyEventJoinRequest({
    required String eventId,
  });

  Future<Either<Failure, bool>> approveUserJoinRequest({
    required Input$ApproveUserJoinRequestsInput input,
  });

  Future<Either<Failure, bool>> declineUserJoinRequest({
    required Input$DeclineUserJoinRequestsInput input,
  });

  Future<Either<Failure, List<EventAcceptedExport>>> exportEventAccepted({
    required String eventId,
  });

  Future<Either<Failure, bool>> submitEventApplicationQuestions({
    required String eventId,
    required List<Input$QuestionInput> questions,
  });
}
