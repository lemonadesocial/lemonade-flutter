import 'package:app/core/domain/space/entities/pin_events_to_space_response.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';

abstract class SpaceRepository {
  Future<Either<Failure, Space>> getSpaceDetail({
    required String spaceId,
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
}
