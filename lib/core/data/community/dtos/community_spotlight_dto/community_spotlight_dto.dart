import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_spotlight_dto.freezed.dart';
part 'community_spotlight_dto.g.dart';

@freezed
class CommunitySpotlightDto with _$CommunitySpotlightDto {
  @JsonSerializable(explicitToJson: true)
  factory CommunitySpotlightDto({
    @JsonKey(name: '_id') required String id,
    required String? username,
    String? name,
    @JsonKey(name: 'image_avatar') String? imageAvatar,
  }) = _CommunitySpotlightDto;

  factory CommunitySpotlightDto.fromJson(Map<String, dynamic> json) =>
      _$CommunitySpotlightDtoFromJson(json);
}
