import 'package:app/core/data/badge/repository/badge_respository_impl.dart';
import 'package:app/core/domain/badge/badge_repository.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

class BadgeService {  
  BadgeRepository badgeRepository = BadgeRepositoryImpl();

  Future<Either<Failure, List<Badge>>> getBadges(GetBadgesInput? input) async {
    return badgeRepository.getBadges(input);
  }

  Future<Either<Failure, List<BadgeList>>> getBadgeCollections(GetBadgeListsInput? input) {
    return badgeRepository.getBadgeCollections(input);
  }
  
  Future<Either<Failure, List<BadgeCity>>> getBadgeCities(GetBadgeCitiesInput? input) {
    return badgeRepository.getBadgeCities(input);
  }
}