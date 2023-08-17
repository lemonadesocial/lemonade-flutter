import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BadgeRepository {
  Future<Either<Failure, List<Badge>>> getBadges(
    GetBadgesInput? input, {
    GeoPoint? geoPoint,
  });

  Future<Either<Failure, List<BadgeList>>> getBadgeCollections(GetBadgeListsInput? input);

  Future<Either<Failure, List<BadgeCity>>> getBadgeCities(GetBadgeCitiesInput? input);
}