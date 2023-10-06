import 'package:app/core/domain/community/community_user/community_user.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CommunityRepository {
  Future<Either<Failure, List<CommunityUser>>> getListFriend(
    String userId, {
    String? searchInput,
  });

  Future<Either<Failure, List<CommunityUser>>> getListFollower(
    String userId, {
    String? searchInput,
  });

  Future<Either<Failure, List<CommunityUser>>> getListFollowee(
    String userId, {
    String? searchInput,
  });
}
