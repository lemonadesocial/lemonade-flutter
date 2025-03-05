import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/space/query/list_space_tags.graphql.dart';
import 'package:app/graphql/backend/space/space.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/domain/space/space_repository.dart';

@LazySingleton(as: SpaceRepository)
class SpaceRepositoryImpl implements SpaceRepository {
  final _client = getIt<AppGQL>().client;
  @override
  Future<Either<Failure, Space>> getSpaceDetail({
    required String spaceId,
  }) async {
    final result = await _client.query$GetSpace(
      Options$Query$GetSpace(
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
}
