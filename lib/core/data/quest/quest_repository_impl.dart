import 'package:app/core/domain/quest/entities/point_config_info.dart';
import 'package:app/core/domain/quest/entities/point_group.dart';
import 'package:app/core/domain/quest/quest_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/quest/query/get_point_groups.graphql.dart';
import 'package:app/graphql/backend/quest/query/get_my_points.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: QuestRepository)
class QuestRepositoryImpl implements QuestRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<PointGroup>>> getPointGroups() async {
    final result = await _client.query$GetPointGroups(
      Options$Query$GetPointGroups(
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      List.from(
        result.parsedData!.getPointGroups
            .map(
              (item) => PointGroup.fromJson(item.toJson()),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<PointConfigInfo>>> getMyPoints({
    required String? firstLevelGroup,
    required String? secondLevelGroup,
  }) async {
    final result = await _client.query$GetMyPoints(
      Options$Query$GetMyPoints(
        variables: Variables$Query$GetMyPoints(
          firstLevelGroup: firstLevelGroup,
          secondLevelGroup: secondLevelGroup,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      List.from(
        result.parsedData!.getMyPoints
            .map(
              (item) => PointConfigInfo.fromJson(item.toJson()),
            )
            .toList(),
      ),
    );
  }
}
