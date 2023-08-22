import 'package:app/core/data/badge/badge_query.dart';
import 'package:app/core/data/badge/dtos/badge_dtos.dart';
import 'package:app/core/domain/badge/badge_repository.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BadgeRepository)
class BadgeRepositoryImpl implements BadgeRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<Badge>>> getBadges(
    GetBadgesInput? input, {
    GeoPoint? geoPoint,
  }) async {
    GraphQLClient queryClient;
    if (geoPoint != null) {
      queryClient = GeoLocationBasedGQL(
        GeoLocationLink(geoPoint: geoPoint),
      ).client;
    } else {
      queryClient = _client;
    }

    final result = await queryClient.query(
      QueryOptions(
        document: getBadgesQuery,
        variables: input?.toJson() ?? {},
        fetchPolicy: geoPoint != null ? FetchPolicy.networkOnly : null,
        parserFn: (data) => List.from(data['getBadges'] ?? [])
            .map(
              (item) => Badge.fromDto(
                BadgeDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<BadgeList>>> getBadgeCollections(GetBadgeListsInput? input) async {
    final result = await _client.query(
      QueryOptions(
        document: getBadgeListsQuery,
        variables: input?.toJson() ?? {},
        parserFn: (data) => List.from(data['getBadgeLists'] ?? [])
            .map(
              (item) => BadgeList.fromDto(
                BadgeListDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<BadgeCity>>> getBadgeCities(GetBadgeCitiesInput? input) async {
    final result = await _client.query(
      QueryOptions(
        document: getBadgeCitiesQuery,
        variables: input?.toJson() ?? {},
        parserFn: (data) => List.from(data['getBadgeCities'] ?? [])
            .map(
              (item) => BadgeCity.fromDto(
                BadgeCityDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData ?? []);
  }
}
