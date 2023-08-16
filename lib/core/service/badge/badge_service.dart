import 'package:app/core/data/badge/repository/badge_respository_impl.dart';
import 'package:app/core/domain/badge/badge_repository.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class BadgeService {  
  List<BadgeList> selectedCollections = [];
  BadgeLocation? selectedLocation;
  double distance = 1;
  
  BadgeRepository badgeRepository = BadgeRepositoryImpl();

  List<BadgeList> addCollection(BadgeList collection) {
    return selectedCollections = [...selectedCollections, collection];
  }

  List<BadgeList> removeCollection(BadgeList collection) {
    return selectedCollections = selectedCollections.where((item) => item.id != collection.id).toList();
  }

  void selectLocation(BadgeLocation? location) {
    selectedLocation = location;
  }

  void updateDistance(double value) {
    if(value < 1) {
      distance = 1;
      return;
    } 
    distance = value;
  }

  Future<Either<Failure, List<Badge>>> getBadges(GetBadgesInput? input) async {
    return badgeRepository.getBadges(input);
  }

  Future<Either<Failure, List<BadgeList>>> getBadgeCollections(GetBadgeListsInput? input) async {
    return badgeRepository.getBadgeCollections(input);
  }
  
  Future<Either<Failure, List<BadgeCity>>> getBadgeCities(GetBadgeCitiesInput? input) {
    return badgeRepository.getBadgeCities(input);
  }
}