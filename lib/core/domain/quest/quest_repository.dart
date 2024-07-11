import 'package:app/core/domain/quest/entities/point_config_info.dart';
import 'package:app/core/domain/quest/entities/point_group.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class QuestRepository {
  Future<Either<Failure, List<PointGroup>>> getPointGroups();

  Future<Either<Failure, List<PointConfigInfo>>> getMyPoints({
    required String? firstLevelGroup,
    required String? secondLevelGroup,
  });
}
