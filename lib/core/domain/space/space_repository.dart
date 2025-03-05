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
}
