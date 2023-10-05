import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_friend_dto.freezed.dart';

part 'community_friend_dto.g.dart';

@freezed
class CommunityFriendDto with _$CommunityFriendDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory CommunityFriendDto({
    @JsonKey(name: '_id') required String id,
    String? state,
    String? user1,
    String? user2,
    CommunityFriendExpandDto? otherExpanded,
  }) = _CommunityFriendDto;

  factory CommunityFriendDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityFriendDtoFromJson(json);
}

@freezed
class CommunityFriendExpandDto with _$CommunityFriendExpandDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory CommunityFriendExpandDto({
    @JsonKey(name: '_id') required String id,
    required String username,
    String? name,
    String? matrixLocalpart,
    @Default([]) List<String?> wallets,
    @Default([]) List<DbFileDto> newPhotosExpanded,
  }) = _CommunityFriendExpandDto;

  factory CommunityFriendExpandDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityFriendExpandDtoFromJson(json);
}
