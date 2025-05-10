import 'package:app/core/domain/space/entities/pin_events_to_space_response.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/mutation/decide_space_event_requests.graphql.dart';
import 'package:app/graphql/backend/space/query/get_my_space_requests.graphql.dart';
import 'package:app/graphql/backend/space/query/get_space_event_requests.graphql.dart';
import 'package:app/graphql/backend/space/mutation/update_space.graphql.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/domain/space/entities/get_space_event_requests_response.dart';

abstract class SpaceRepository {
  Future<Either<Failure, Space>> getSpaceDetail({
    required String spaceId,
    bool refresh = false,
  });

  Future<Either<Failure, List<SpaceTag>>> listSpaceTags({
    required String spaceId,
  });

  Future<Either<Failure, bool>> followSpace({
    required String spaceId,
  });

  Future<Either<Failure, bool>> unfollowSpace({
    required String spaceId,
  });

  Future<Either<Failure, PinEventsToSpaceResponse>> pinEventsToSpace({
    required List<String> events,
    required String spaceId,
    List<String>? tags,
  });

  Future<Either<Failure, List<Space>>> listSpaces({
    bool? withMySpaces,
    bool? withPublicSpaces,
    List<Enum$SpaceRole>? roles,
  });

  Future<Either<Failure, GetSpaceEventRequestsResponse>>
      getMySpaceEventRequests({
    required Variables$Query$GetMySpaceEventRequests input,
  });

  Future<Either<Failure, GetSpaceEventRequestsResponse>> getSpaceEventRequests({
    required Variables$Query$GetSpaceEventRequests input,
    bool refresh = false,
  });

  Future<Either<Failure, bool>> decideSpaceEventRequests({
    required Variables$Mutation$DecideSpaceEventRequests input,
  });

  Future<Either<Failure, Space>> updateSpace({
    required Variables$Mutation$UpdateSpace input,
  });
}
