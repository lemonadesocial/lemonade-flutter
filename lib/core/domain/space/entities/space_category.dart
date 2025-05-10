import 'package:app/core/data/space/dtos/space_category_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_category.freezed.dart';
part 'space_category.g.dart';

@freezed
class SpaceCategory with _$SpaceCategory {
  const factory SpaceCategory({
    required String title,
    String? description,
    String? imageUrl,
    required String space,
    int? listedEventsCount,
  }) = _SpaceCategory;

  factory SpaceCategory.fromJson(Map<String, dynamic> json) =>
      _$SpaceCategoryFromJson(json);

  factory SpaceCategory.fromDto(SpaceCategoryDto dto) {
    return SpaceCategory(
      title: dto.title,
      description: dto.description,
      imageUrl: dto.imageUrl,
      space: dto.space,
      listedEventsCount: dto.listedEventsCount,
    );
  }
}
