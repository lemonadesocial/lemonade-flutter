import 'package:app/core/data/space/dtos/space_tag_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_tag.freezed.dart';
part 'space_tag.g.dart';

@freezed
class SpaceTag with _$SpaceTag {
  const factory SpaceTag({
    required String id,
    required String spaceId,
    required String tag,
    required String color,
    required Enum$SpaceTagType type,
    List<String>? targets,
  }) = _SpaceTag;

  factory SpaceTag.fromJson(Map<String, dynamic> json) =>
      _$SpaceTagFromJson(json);

  factory SpaceTag.fromDto(SpaceTagDto dto) {
    return SpaceTag(
      id: dto.id,
      spaceId: dto.space,
      tag: dto.tag,
      color: dto.color,
      type: dto.type,
      targets: dto.targets,
    );
  }
}
