import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_follower_dto.freezed.dart';

part 'community_follower_dto.g.dart';

@freezed
class CommunityFollowerDto with _$CommunityFollowerDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory CommunityFollowerDto({
    @JsonKey(name: 'follower_expanded')
    required List<CommunityExpandDto> expandDto,
  }) = _CommunityFollowerDto;

  factory CommunityFollowerDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityFollowerDtoFromJson(json);
}

@freezed
class CommunityFolloweeDto with _$CommunityFolloweeDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory CommunityFolloweeDto({
    @JsonKey(name: 'followee_expanded')
    required List<CommunityExpandDto> expandDto,
  }) = _CommunityFolloweeDto;

  factory CommunityFolloweeDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityFolloweeDtoFromJson(json);
}

@freezed
class CommunityExpandDto with _$CommunityExpandDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory CommunityExpandDto({
    @JsonKey(name: '_id') required String id,
    required String username,
    String? name,
    @Default([]) List<String?> newPhotos,
    String? imageAvatar,
  }) = _CommunityExpandDto;

  factory CommunityExpandDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityExpandDtoFromJson(json);
}
