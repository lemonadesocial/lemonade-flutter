import 'package:app/core/data/community/community_query.dart';
import 'package:app/core/data/community/dtos/community_follower_dto/community_follower_dto.dart';
import 'package:app/core/data/community/dtos/community_friend_dto/community_friend_dto.dart';
import 'package:app/core/data/community/dtos/community_spotlight_dto/community_spotlight_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/community/community_repository.dart';
import 'package:app/core/domain/community/community_user/community_user.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CommunityRepository)
class CommunityRepositoryImpl extends CommunityRepository {
  final _gqlClient = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<CommunityUser>>> getListFollower(
    String userId, {
    String? searchInput,
  }) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserFollower,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          'followee': userId,
          'follower_search': searchInput,
        },
        parserFn: (data) {
          final receiveList = data['getUserFollows'] as List<dynamic>;
          return receiveList
              .map(
                (e) => CommunityUser.fromExpandDto(
                  CommunityFollowerDto.fromJson(e).expandDto,
                ),
              )
              .toList();
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<CommunityUser>>> getListFollowee(
    String userId, {
    String? searchInput,
  }) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserFollowee,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          'follower': userId,
          'followee_search': searchInput,
        },
        parserFn: (data) {
          final receiveList = data['getUserFollows'] as List<dynamic>;
          return receiveList
              .map(
                (item) => CommunityUser.fromDto(
                  CommunitySpotlightDto.fromJson(item),
                ),
              )
              .toList();
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<CommunityUser>>> getListFriend(
    String userId, {
    String? searchInput,
  }) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserFriendShip,
        variables: {
          'limit': 21,
          'skip': 0,
          'state': 'accepted',
          'user': userId,
          'other_search': searchInput,
        },
        parserFn: (data) {
          final payload =
              CommunityFriendPayloadDto.fromJson(data['friendships']);
          return payload.items == null
              ? <CommunityUser>[]
              : payload.items!
                  .map(
                    (item) => CommunityUser.fromFriendDto(item),
                  )
                  .toList();
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<CommunityUser>>> getUsersSpotlight() async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUsersSpotlightQuery,
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) {
          final receiveList = data['getUsersSpotlight'] as List<dynamic>;
          return receiveList
              .map(
                (item) => CommunityUser.fromDto(
                  CommunitySpotlightDto.fromJson(item),
                ),
              )
              .toList();
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }
}
