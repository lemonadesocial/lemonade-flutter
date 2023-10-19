import 'package:app/core/data/user/dtos/user_follows/user_follow_dtos.dart';

class UserFollow {
  const UserFollow({
    this.followee,
    this.follower,
  });

  factory UserFollow.fromDto(UserFollowDto dto) {
    return UserFollow(
      followee: dto.followee,
      follower: dto.follower,
    );
  }

  final String? followee;
  final String? follower;
}
