import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_tag_dto.freezed.dart';
part 'space_tag_dto.g.dart';

@freezed
class SpaceTagDto with _$SpaceTagDto {
  const factory SpaceTagDto({
    @JsonKey(name: '_id') required String id,
    required String space,
    required String tag,
    required String color,
    required Enum$SpaceTagType type,
    List<String>? targets,
  }) = _SpaceTagDto;

  factory SpaceTagDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceTagDtoFromJson(json);
}
