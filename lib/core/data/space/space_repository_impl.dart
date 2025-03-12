import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/mutation/pin_events_to_space.graphql.dart';
import 'package:app/graphql/backend/space/space.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/data/space/dtos/space_event_request_dto.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/domain/space/entities/pin_events_to_space_response.dart';
import 'package:app/core/data/space/dtos/get_space_event_requests_response_dto.dart';
import 'package:app/core/domain/space/entities/get_space_event_requests_response.dart';

@LazySingleton(as: SpaceRepository)
class SpaceRepositoryImpl implements SpaceRepository {
  final _client = getIt<AppGQL>().client;
  @override
  Future<Either<Failure, Space>> getSpaceDetail({
    required String spaceId,
    bool refresh = false,
  }) async {
    final result = await _client.query$GetSpace(
      Options$Query$GetSpace(
        fetchPolicy: refresh ? FetchPolicy.networkOnly : null,
        variables: Variables$Query$GetSpace(
          id: spaceId,
        ),
      ),
    );
    if (result.hasException || result.parsedData?.getSpace == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    return Right(
      Space.fromDto(
        SpaceDto.fromJson(
          result.parsedData!.getSpace!.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, List<SpaceTag>>> listSpaceTags({
    required String spaceId,
  }) async {
    final result = await _client.query$ListSpaceTags(
      Options$Query$ListSpaceTags(
        variables: Variables$Query$ListSpaceTags(
          space: spaceId,
        ),
      ),
    );
    if (result.hasException || result.parsedData?.listSpaceTags == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    return Right(
      result.parsedData!.listSpaceTags
          .map((e) => SpaceTag.fromJson(e.toJson()))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, bool>> followSpace({
    required String spaceId,
  }) async {
    final result = await _client.mutate$FollowSpace(
      Options$Mutation$FollowSpace(
        variables: Variables$Mutation$FollowSpace(
          space: spaceId,
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }

    final success = result.parsedData?.followSpace ?? false;
    return Right(success);
  }

  @override
  Future<Either<Failure, bool>> unfollowSpace({
    required String spaceId,
  }) async {
    final result = await _client.mutate$UnfollowSpace(
      Options$Mutation$UnfollowSpace(
        variables: Variables$Mutation$UnfollowSpace(
          space: spaceId,
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }

    final success = result.parsedData?.unfollowSpace ?? false;
    return Right(success);
  }

  @override
  Future<Either<Failure, PinEventsToSpaceResponse>> pinEventsToSpace({
    required List<String> events,
    required String spaceId,
    List<String>? tags,
  }) async {
    final result = await _client.mutate$PinEventsToSpace(
      Options$Mutation$PinEventsToSpace(
        variables: Variables$Mutation$PinEventsToSpace(
          events: events,
          space: spaceId,
          tags: tags,
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }

    final requests = result.parsedData?.pinEventsToSpace.requests
        ?.map(
          (e) => SpaceEventRequest.fromDto(
            SpaceEventRequestDto.fromJson(e.toJson()),
          ),
        )
        .toList();

    return Right(PinEventsToSpaceResponse(requests: requests));
  }

  @override
  Future<Either<Failure, List<Space>>> listSpaces({
    bool? withMySpaces,
    bool? withPublicSpaces,
    List<Enum$SpaceRole>? roles,
  }) async {
    final result = await _client.query$ListSpaces(
      Options$Query$ListSpaces(
        variables: Variables$Query$ListSpaces(
          with_my_spaces: withMySpaces,
          with_public_spaces: withPublicSpaces,
          roles: roles,
        ),
      ),
    );

    if (result.hasException || result.parsedData?.listSpaces == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    final spaces = result.parsedData?.listSpaces ?? [];
    return Right(
      spaces
          .map(
            (space) => Space.fromDto(
              SpaceDto.fromJson(
                space.toJson(),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, GetSpaceEventRequestsResponse>>
      getMySpaceEventRequests({
    required Variables$Query$GetMySpaceEventRequests input,
  }) async {
    final result = await _client.query$GetMySpaceEventRequests(
      Options$Query$GetMySpaceEventRequests(
        variables: input,
      ),
    );

    if (result.hasException ||
        result.parsedData?.getMySpaceEventRequests == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    final responseDto = GetSpaceEventRequestsResponseDto.fromJson(
      result.parsedData!.getMySpaceEventRequests.toJson(),
    );

    return Right(GetSpaceEventRequestsResponse.fromDto(responseDto));
  }
}
