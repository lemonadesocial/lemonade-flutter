import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';

part 'space.freezed.dart';
part 'space.g.dart';

@freezed
class Space with _$Space {
  const factory Space({
    String? id,
    String? title,
    String? description,
    String? creatorId,
    bool? private,
    Enum$SpaceState? state,
    bool? personal,
    List<String>? followers,
    SpaceDao? daos,
    String? tintColor,
    String? slug,
    String? handleTwitter,
    String? handleInstagram,
    String? handleYoutube,
    String? handleTiktok,
    String? handleLinkedin,
    String? website,
    Address? address,
    String? imageAvatarId,
    String? imageCoverId,
    List<String>? listedEvents,
    bool? followed,
    bool? isAmbassador,
    List<User>? admins,
    User? creator,
    DbFile? imageAvatar,
    DbFile? imageCover,
  }) = _Space;

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  factory Space.fromDto(SpaceDto dto) {
    return Space(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      creatorId: dto.creatorId,
      private: dto.private,
      state: dto.state,
      personal: dto.personal,
      followers: dto.followers,
      daos: dto.daos != null ? SpaceDao.fromDto(dto.daos!) : null,
      tintColor: dto.tintColor,
      slug: dto.slug,
      handleTwitter: dto.handleTwitter,
      handleInstagram: dto.handleInstagram,
      handleYoutube: dto.handleYoutube,
      handleTiktok: dto.handleTiktok,
      handleLinkedin: dto.handleLinkedin,
      website: dto.website,
      address: dto.address != null ? Address.fromDto(dto.address!) : null,
      imageAvatarId: dto.imageAvatarId,
      imageCoverId: dto.imageCoverId,
      listedEvents: dto.listedEvents,
      followed: dto.followed,
      isAmbassador: dto.isAmbassador,
      admins: dto.admins?.map((e) => User.fromDto(e)).toList(),
      creator: dto.creatorExpanded != null
          ? User.fromDto(dto.creatorExpanded!)
          : null,
      imageAvatar: dto.imageAvatarExpanded != null
          ? DbFile.fromDto(dto.imageAvatarExpanded!)
          : null,
      imageCover: dto.imageCoverExpanded != null
          ? DbFile.fromDto(dto.imageCoverExpanded!)
          : null,
    );
  }
}

@freezed
class SpaceDao with _$SpaceDao {
  const factory SpaceDao({
    required String network,
    required String address,
    required String name,
  }) = _SpaceDao;

  factory SpaceDao.fromJson(Map<String, dynamic> json) =>
      _$SpaceDaoFromJson(json);

  factory SpaceDao.fromDto(SpaceDaoDto dto) {
    return SpaceDao(
      network: dto.network,
      address: dto.address,
      name: dto.name,
    );
  }
}
