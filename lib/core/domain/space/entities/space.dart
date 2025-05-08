import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';

part 'space.freezed.dart';
part 'space.g.dart';

@freezed
class Space with _$Space {
  const Space._();

  const factory Space({
    String? id,
    String? title,
    String? description,
    String? creator,
    User? creatorExpanded,
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
    DbFile? imageAvatar,
    DbFile? imageCover,
    String? lensFeedId,
  }) = _Space;

  bool isCreator({required String userId}) {
    if (creator == null) {
      return false;
    }
    return creator == userId;
  }

  bool isAdmin({required String userId}) {
    if (admins == null || admins!.isEmpty) {
      return false;
    }
    return admins!.any((admin) => admin.userId == userId);
  }

  bool isFollower({required String userId}) {
    if (followed == true) {
      return true;
    }
    if (followers == null || followers!.isEmpty) {
      return false;
    }
    return followers!.contains(userId);
  }

  bool canInsertTag({required String userId}) {
    return isAdmin(userId: userId) || isCreator(userId: userId);
  }

  bool canFollow({required String userId}) {
    return !isCreator(userId: userId) &&
        !isAdmin(userId: userId) &&
        !(isAmbassador == true);
  }

  String getSpaceImageUrl() {
    final isPersonal = personal ?? false;
    if (isPersonal) {
      return creatorExpanded?.imageAvatar ?? '';
    }
    return imageCover?.url ?? imageAvatar?.url ?? '';
  }

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  factory Space.fromDto(SpaceDto dto) {
    return Space(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      creator: dto.creator,
      creatorExpanded: dto.creatorExpanded != null
          ? User.fromDto(dto.creatorExpanded!)
          : null,
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
      admins: (dto.admins ?? []).map((e) => User.fromDto(e)).toList(),
      imageAvatar: dto.imageAvatarExpanded != null
          ? DbFile.fromDto(dto.imageAvatarExpanded!)
          : null,
      imageCover: dto.imageCoverExpanded != null
          ? DbFile.fromDto(dto.imageCoverExpanded!)
          : null,
      lensFeedId: dto.lensFeedId,
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
