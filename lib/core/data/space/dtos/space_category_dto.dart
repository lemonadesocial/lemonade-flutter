import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_category_dto.freezed.dart';
part 'space_category_dto.g.dart';

@freezed
class SpaceCategoryDto with _$SpaceCategoryDto {
  const factory SpaceCategoryDto({
    required String title,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    required String space,
    @JsonKey(name: 'listed_events_count') int? listedEventsCount,
  }) = _SpaceCategoryDto;

  factory SpaceCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceCategoryDtoFromJson(json);
}
