import 'package:app/core/data/community/dtos/community_follower_dto/community_follower_dto.dart';
import 'package:app/core/data/community/dtos/community_friend_dto/community_friend_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_user.freezed.dart';

@freezed
class CommunityUser with _$CommunityUser {
  factory CommunityUser({
    required String id,
    required String? userName,
    String? displayName,
    @Default([]) List<String?> newPhotos,
    String? imageAvatar,
  }) = _CommunityUser;

  factory CommunityUser.fromFriendDto(CommunityFriendDto dto) {
    return CommunityUser(
      id: dto.otherExpanded!.id,
      userName: dto.otherExpanded!.username,
      displayName: dto.otherExpanded!.name,
      newPhotos:
          dto.otherExpanded!.newPhotosExpanded.map((e) => e.url).toList(),
    );
  }

  factory CommunityUser.fromExpandDto(CommunityExpandDto dto) {
    return CommunityUser(
      id: dto.id,
      userName: dto.username,
      displayName: dto.name,
      newPhotos: dto.newPhotos,
      imageAvatar: dto.imageAvatar,
    );
  }
}
