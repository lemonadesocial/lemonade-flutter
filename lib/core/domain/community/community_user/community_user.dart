import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_user.freezed.dart';

@freezed
class CommunityUser with _$CommunityUser {
  factory CommunityUser({
    required String id,
    required String userName,
    String? displayName,
    @Default([]) List<String?> newPhotos,
    String? imageAvatar,
  }) = _CommunityUser;
}
