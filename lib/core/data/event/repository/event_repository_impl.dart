import 'package:app/core/data/event/dtos/event_application_answer_dto/event_application_answer_dto.dart';
import 'package:app/core/data/event/dtos/event_cohost_request_dto/event_cohost_request_dto.dart';
import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/event/dtos/event_invite_dto/event_invite_dto.dart';
import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/data/event/dtos/event_rsvp_dto/event_rsvp_dto.dart';
import 'package:app/core/data/event/dtos/event_story_dto/event_story_dto.dart';
import 'package:app/core/data/event/dtos/event_voting_dto/event_voting_dto.dart';
import 'package:app/core/data/event/dtos/generate_event_invitation_url_response_dto/generate_event_invitation_url_response_dto.dart';
import 'package:app/core/data/event/gql/event_mutation.dart';
import 'package:app/core/data/event/gql/event_query.dart';
import 'package:app/core/data/event/gql/watch_event_voting_updated.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_invite.dart';
import 'package:app/core/domain/event/entities/event_ticket_export.dart';
import 'package:app/core/domain/event/entities/event_application_answer.dart';
import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/entities/event_rsvp.dart';
import 'package:app/core/domain/event/entities/event_story.dart';
import 'package:app/core/domain/event/entities/event_voting.dart';
import 'package:app/core/domain/event/entities/generate_event_invitation_url_response.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/mutation/create_event.graphql.dart';
import 'package:app/graphql/backend/event/mutation/create_event_story.graphql.dart';
import 'package:app/graphql/backend/event/mutation/decide_user_join_request.graphql.dart';
import 'package:app/graphql/backend/event/mutation/submit_event_application_answers.graphql.dart';
import 'package:app/graphql/backend/event/mutation/submit_event_application_questions.graphql.dart';
import 'package:app/graphql/backend/event/mutation/manage_event_cohost_requests.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event.graphql.dart';
import 'package:app/graphql/backend/event/mutation/cancel_event.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event_story_image.graphql.dart';
import 'package:app/graphql/backend/event/query/export_event_tickets.graphql.dart';
import 'package:app/graphql/backend/event/query/generate_event_invitation_url.graphql.dart';
import 'package:app/graphql/backend/event/query/get_event_application_answers.graphql.dart';
import 'package:app/graphql/backend/event/query/get_event_cohost_requests.graphql.dart';
import 'package:app/graphql/backend/event/query/get_event_checkins.graphql.dart';
import 'package:app/graphql/backend/event/query/get_event_pending_invites.graphql.dart';
import 'package:app/graphql/backend/event/query/list_event_votings.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:app/graphql/backend/event/query/get_event_join_request.graphql.dart';
import 'package:app/graphql/backend/event/query/get_my_event_join_request.graphql.dart';
import 'package:matrix/matrix.dart' as matrix;

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
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => List.from(data['getHostingEvents'])
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
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => List.from(data['getUpcomingEvents'])
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
  Future<Either<Failure, List<EventCheckin>>> updateEventCheckin({
    required Input$UpdateEventCheckinInput input,
  }) async {
    final result = await client.mutate$UpdateEventCheckins(
      Options$Mutation$UpdateEventCheckins(
        variables: Variables$Mutation$UpdateEventCheckins(input: input),
      ),
    );
    if (result.hasException || result.parsedData?.updateEventCheckins == null) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      List.from(
        result.parsedData!.updateEventCheckins
            .map(
              (item) => EventCheckin.fromJson(item.toJson()),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<EventCheckin>>> getEventCheckins({
    required Input$GetEventCheckinsInput input,
  }) async {
    final result = await client.query$GetEventCheckins(
      Options$Query$GetEventCheckins(
        variables: Variables$Query$GetEventCheckins(input: input),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      List.from(
        result.parsedData!.getEventCheckins
            .map(
              (item) => EventCheckin.fromJson(item.toJson()),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<EventJoinRequest>>> getEventJoinRequests({
    required Variables$Query$GetEventJoinRequests input,
  }) async {
    final result = await client.query$GetEventJoinRequests(
      Options$Query$GetEventJoinRequests(
        variables: input,
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      (result.parsedData?.getEventJoinRequests.records ?? [])
          .map(
            (item) => EventJoinRequest.fromDto(
              EventJoinRequestDto.fromJson(
                item.toJson(),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, EventJoinRequest>> getEventJoinRequest({
    required Variables$Query$GetEventJoinRequest input,
    FetchPolicy? fetchPolicy,
  }) async {
    final result = await client.query$GetEventJoinRequest(
      Options$Query$GetEventJoinRequest(
        variables: input,
        fetchPolicy: fetchPolicy,
      ),
    );

    if (result.hasException || result.parsedData?.getEventJoinRequest == null) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      EventJoinRequest.fromDto(
        EventJoinRequestDto.fromJson(
          result.parsedData!.getEventJoinRequest.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, EventJoinRequest?>> getMyEventJoinRequest({
    required String eventId,
  }) async {
    final result = await client.query$GetMyEventJoinRequest(
      Options$Query$GetMyEventJoinRequest(
        variables: Variables$Query$GetMyEventJoinRequest(event: eventId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }

    if (result.parsedData?.getMyEventJoinRequest == null) {
      return const Right(null);
    }

    return Right(
      EventJoinRequest.fromDto(
        EventJoinRequestDto.fromJson(
          result.parsedData!.getMyEventJoinRequest!.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> approveUserJoinRequest({
    required Input$DecideUserJoinRequestsInput input,
  }) async {
    final result = await client.mutate$DecideUserJoinRequests(
      Options$Mutation$DecideUserJoinRequests(
        variables: Variables$Mutation$DecideUserJoinRequests(
          input: input,
        ),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData?.decideUserJoinRequests.isNotEmpty == true);
  }

  @override
  Future<Either<Failure, bool>> declineUserJoinRequest({
    required Input$DecideUserJoinRequestsInput input,
  }) async {
    final result = await client.mutate$DecideUserJoinRequests(
      Options$Mutation$DecideUserJoinRequests(
        variables: Variables$Mutation$DecideUserJoinRequests(
          input: input,
        ),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData?.decideUserJoinRequests.isNotEmpty == true);
  }

  @override
  Future<Either<Failure, List<EventTicketExport>>> exportEventTickets({
    required String eventId,
  }) async {
    final result = await client.query$ExportEventTickets(
      Options$Query$ExportEventTickets(
        variables: Variables$Query$ExportEventTickets(
          id: eventId,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }

    return Right(
      (result.parsedData?.exportEventTickets.tickets ?? [])
          .map(
            (item) => EventTicketExport.fromJson(
              item.toJson(),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, bool>> submitEventApplicationQuestions({
    required String eventId,
    required List<Input$QuestionInput> questions,
  }) async {
    final result = await client.mutate$SubmitEventApplicationQuestions(
      Options$Mutation$SubmitEventApplicationQuestions(
        variables: Variables$Mutation$SubmitEventApplicationQuestions(
          event: eventId,
          questions: questions,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData?.submitEventApplicationQuestions != null);
  }

  @override
  Future<Either<Failure, List<EventApplicationAnswer>>>
      getEventApplicationAnswers({
    required String eventId,
    required String userId,
  }) async {
    final result = await client.query$GetEventApplicationAnswers(
      Options$Query$GetEventApplicationAnswers(
        variables: Variables$Query$GetEventApplicationAnswers(
          event: eventId,
          user: userId,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      (result.parsedData?.getEventApplicationAnswers ?? [])
          .map(
            (item) => EventApplicationAnswer.fromDto(
              EventApplicationAnswerDto.fromJson(item.toJson()),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, bool>> submitEventApplicationAnswers({
    required String eventId,
    required List<Input$EventApplicationAnswerInput> answers,
  }) async {
    final result = await client.mutate$SubmitEventApplicationAnswers(
      Options$Mutation$SubmitEventApplicationAnswers(
        variables: Variables$Mutation$SubmitEventApplicationAnswers(
          event: eventId,
          answers: answers,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData?.submitEventApplicationAnswers ?? false);
  }

  @override
  Future<Either<Failure, bool>> createEventStory({
    required Input$EventStoryInput input,
  }) async {
    final result = await client.mutate$CreateEventStory(
      Options$Mutation$CreateEventStory(
        variables: Variables$Mutation$CreateEventStory(input: input),
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!.createEventStory);
  }

  @override
  Future<Either<Failure, EventStory>> updateEventStoryImage({
    required Variables$Mutation$UpdateEventStoryImage input,
  }) async {
    final result = await client.mutate$UpdateEventStoryImage(
      Options$Mutation$UpdateEventStoryImage(
        variables: input,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      EventStory.fromDto(
        EventStoryDto.fromJson(
          result.parsedData!.story.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Event>> cancelEvent({
    required String eventId,
  }) async {
    final result = await client.mutate$CancelEvent(
      Options$Mutation$CancelEvent(
        variables: Variables$Mutation$CancelEvent(id: eventId),
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      Event.fromDto(
        EventDto.fromJson(
          result.parsedData!.cancelEvent.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, GenerateEventInvitationUrlResponse>>
      generateEventInvitationUrl({
    required String eventId,
  }) async {
    final result = await client.query$GenerateEventInvitationUrl(
      Options$Query$GenerateEventInvitationUrl(
        variables: Variables$Query$GenerateEventInvitationUrl(event: eventId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(
      GenerateEventInvitationUrlResponse.fromDto(
        GenerateEventInvitationUrlResponseDto.fromJson(
          result.parsedData!.generateEventInvitationUrl?.toJson() ?? {},
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, List<EventVoting>>> getEventVotings({
    required Variables$Query$ListEventVotings input,
  }) async {
    try {
      final result = await client.query$ListEventVotings(
        Options$Query$ListEventVotings(
          variables: input,
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException || result.parsedData == null) {
        return Left(Failure.withGqlException(result.exception));
      }

      final votingsData = result.parsedData?.listEventVotings ?? [];

      return Right(
        votingsData
            .map(
              (dto) => EventVoting.fromDto(
                EventVotingDto.fromJson(dto.toJson()),
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Stream<String> watchEventVotingUpdated({
    required String votingId,
  }) {
    return client
        .subscribe(
          SubscriptionOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: watchVotingUpdatedSubscription,
            variables: {
              'id': votingId,
            },
          ),
        )
        .asyncMap((result) => result.data?.tryGet('votingUpdated') ?? '');
  }

  @override
  Future<Either<Failure, GetEventPendingInvitesResponse>>
      getEventPendingInvites() async {
    final result = await client.query$GetEventPendingInvites(
      Options$Query$GetEventPendingInvites(
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    final invitesData = result.parsedData!.getEventPendingInvites;

    return Right(
      GetEventPendingInvitesResponse(
        eventInvites: (invitesData.event_invites ?? [])
            .map(
              (dto) =>
                  EventInvite.fromDto(EventInviteDto.fromJson(dto.toJson())),
            )
            .toList(),
        cohostRequests: (invitesData.cohost_requests ?? [])
            .map(
              (dto) =>
                  EventInvite.fromDto(EventInviteDto.fromJson(dto.toJson())),
            )
            .toList(),
      ),
    );
  }

  // @override
  // Future<Either<Failure, List<EventRole>>> getEventRoles() async {
  //   final result = await client.query$GetEventRoles(
  //     Options$Query$GetEventRoles(
  //       fetchPolicy: FetchPolicy.noCache,
  //     ),
  //   );
  //   if (result.hasException) {
  //     return Left(Failure.withGqlException(result.exception));
  //   }
  //   return Right(
  //     (result.parsedData?.getRoles ?? [])
  //         .map(
  //           (item) => EventRole.fromDto(
  //             EventRoleDto.fromJson(item.toJson()),
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  // @override
  // Future<Either<Failure, List<EventUserRole>>> getListUserRoles({
  //   required String eventId,
  //   String? roleId,
  //   String? searchCriteria,
  // }) async {
  //   final result = await client.query$GetListUserRole(
  //     Options$Query$GetListUserRole(
  //       fetchPolicy: FetchPolicy.noCache,
  //       variables: Variables$Query$GetListUserRole(
  //         input: Input$EventRoleFilter(
  //           event_id: eventId,
  //         ),
  //       ),
  //     ),
  //   );
  //   if (result.hasException || result.parsedData == null) {
  //     return Left(Failure.withGqlException(result.exception));
  //   }
  //   return Right(
  //     (result.parsedData?.getListUserRole ?? [])
  //         .map(
  //           (item) => EventUserRole.fromDto(
  //             EventUserRoleDto.fromJson(item.toJson()),
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  // @override
  // Future<Either<Failure, EventUserRole>> getEventUserRole({
  //   required String eventId,
  //   required String userId,
  // }) async {
  //   final result = await client.query$GetUserRole(
  //     Options$Query$GetUserRole(
  //       fetchPolicy: FetchPolicy.noCache,
  //       variables: Variables$Query$GetUserRole(
  //         input: Input$UserRoleInput(
  //           user_id: userId,
  //           event_id: eventId,
  //         ),
  //       ),
  //     ),
  //   );
  //   if (result.hasException || result.parsedData == null) {
  //     return Left(Failure.withGqlException(result.exception));
  //   }

  //   return Right(
  //     EventUserRole.fromDto(
  //       EventUserRoleDto.fromJson(
  //         result.parsedData!.getUserRole.toJson(),
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Future<Either<Failure, bool>> addUserRole({
  //   required String eventId,
  //   required List<Input$RoleInput> roles,
  //   required List<Input$UserFilter> users,
  // }) async {
  //   final result = await client.mutate$AddUserRole(
  //     Options$Mutation$AddUserRole(
  //       variables: Variables$Mutation$AddUserRole(
  //         input: Input$EventRoleInput(
  //           users: users,
  //           roles: roles,
  //           event_id: eventId,
  //         ),
  //       ),
  //     ),
  //   );
  //   if (result.hasException || result.parsedData == null) {
  //     return Left(Failure.withGqlException(result.exception));
  //   }
  //   return Right(result.parsedData!.addUserRole);
  // }

  // @override
  // Future<Either<Failure, bool>> updateUserRole({
  //   required String eventId,
  //   required List<Input$RoleInput> roles,
  //   required List<Input$UserFilter> users,
  // }) async {
  //   final result = await client.mutate$UpdateUserRole(
  //     Options$Mutation$UpdateUserRole(
  //       variables: Variables$Mutation$UpdateUserRole(
  //         input: Input$EventRoleInput(
  //           users: users,
  //           roles: roles,
  //           event_id: eventId,
  //         ),
  //       ),
  //     ),
  //   );
  //   if (result.hasException || result.parsedData == null) {
  //     return Left(Failure.withGqlException(result.exception));
  //   }
  //   return Right(result.parsedData!.updateUserRole);
  // }

  // @override
  // Future<Either<Failure, bool>> deleteUserRole({
  //   required String eventId,
  //   required List<Input$UserFilter> users,
  // }) async {
  //   final result = await client.mutate$DeleteUserRole(
  //     Options$Mutation$DeleteUserRole(
  //       variables: Variables$Mutation$DeleteUserRole(
  //         input: Input$EventRoleInput(
  //           users: users,
  //           event_id: eventId,
  //         ),
  //       ),
  //     ),
  //   );
  //   if (result.hasException || result.parsedData == null) {
  //     return Left(Failure.withGqlException(result.exception));
  //   }
  //   return Right(result.parsedData!.deleteUserRole);
  // }
}
