import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_dto.freezed.dart';
part 'space_dto.g.dart';

@freezed
class SpaceDto with _$SpaceDto {
  const factory SpaceDto({
    @JsonKey(name: '_id') required String id,
    String? title,
    String? description,
    @JsonKey(name: 'creator') String? creator,
    @JsonKey(name: 'creator_expanded') UserDto? creatorExpanded,
    bool? private,
    Enum$SpaceState? state,
    bool? personal,
    List<String>? followers,
    SpaceDaoDto? daos,
    @JsonKey(name: 'tint_color') String? tintColor,
    String? slug,
    @JsonKey(name: 'handle_twitter') String? handleTwitter,
    @JsonKey(name: 'handle_instagram') String? handleInstagram,
    @JsonKey(name: 'handle_youtube') String? handleYoutube,
    @JsonKey(name: 'handle_tiktok') String? handleTiktok,
    @JsonKey(name: 'handle_linkedin') String? handleLinkedin,
    String? website,
    AddressDto? address,
    @JsonKey(name: 'image_avatar') String? imageAvatarId,
    @JsonKey(name: 'image_cover') String? imageCoverId,
    @JsonKey(name: 'listed_events') List<String>? listedEvents,
    bool? followed,
    @JsonKey(name: 'is_ambassador') bool? isAmbassador,
    List<UserDto>? admins,
    @JsonKey(name: 'image_avatar_expanded') DbFileDto? imageAvatarExpanded,
    @JsonKey(name: 'image_cover_expanded') DbFileDto? imageCoverExpanded,
    @JsonKey(name: 'lens_feed_id') String? lensFeedId,
    @JsonKey(name: 'sub_spaces') List<String>? subSpaces,
    @JsonKey(name: 'sub_spaces_expanded') List<SpaceDto>? subSpacesExpanded,
  }) = _SpaceDto;

  factory SpaceDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceDtoFromJson(json);
}

@freezed
class SpaceDaoDto with _$SpaceDaoDto {
  const factory SpaceDaoDto({
    required String network,
    required String address,
    required String name,
  }) = _SpaceDaoDto;

  factory SpaceDaoDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceDaoDtoFromJson(json);
}
