import 'package:app/core/data/community/dtos/community_follower_dto/community_follower_dto.dart';
import 'package:app/core/data/community/dtos/community_friend_dto/community_friend_dto.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CommunityRepository {
  Future<Either<Failure, List<CommunityFriendDto>>> getListFriend(
    String userId, {
    String? searchInput,
  });

  Future<Either<Failure, List<CommunityFollowerDto>>> getListFollower(
    String userId, {
    String? searchInput,
  });

  Future<Either<Failure, List<CommunityFolloweeDto>>> getListFollowee(
    String userId, {
    String? searchInput,
  });
}
