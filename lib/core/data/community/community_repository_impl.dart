import 'package:app/core/data/community/community_query.dart';
import 'package:app/core/data/community/dtos/community_follower_dto/community_follower_dto.dart';
import 'package:app/core/data/community/dtos/community_friend_dto/community_friend_dto.dart';
import 'package:app/core/domain/community/community_repository.dart';
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
  Future<Either<Failure, List<CommunityFollowerDto>>> getListFollower(
    String userId, {
    String? searchInput,
  }) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserFollower,
        variables: {
          'limit': 21,
          'followee': userId,
          'follower_search': searchInput,
        },
        parserFn: (data) {
          final receiveList =
              data['getUserFollows'] as List<Map<String, dynamic>>;
          return receiveList
              .map((e) => CommunityFollowerDto.fromJson(e))
              .toList();
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<CommunityFolloweeDto>>> getListFollowee(
    String userId, {
    String? searchInput,
  }) async {
    final result = await _gqlClient.query(
      QueryOptions(
        document: getUserFollowee,
        variables: {
          'follower': userId,
          'followee_search': searchInput,
        },
        parserFn: (data) {
          final receiveList =
              data['getUserFollows'] as List<Map<String, dynamic>>;
          return receiveList
              .map((e) => CommunityFolloweeDto.fromJson(e))
              .toList();
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<CommunityFriendDto>>> getListFriend(
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
          final friendList =
              data['friendships']['items'] as List<Map<String, dynamic>>;
          return friendList.map((e) => CommunityFriendDto.fromJson(e)).toList();
        },
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }
}
