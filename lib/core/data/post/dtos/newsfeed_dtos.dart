import 'package:app/core/data/post/dtos/post_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'newsfeed_dtos.freezed.dart';
part 'newsfeed_dtos.g.dart';

@freezed
class NewsfeedDto with _$NewsfeedDto {
  const factory NewsfeedDto({
    @JsonKey(name: 'posts') List<PostDto>? posts,
    int? offset,
  }) = _NewsfeedDto;

  factory NewsfeedDto.fromJson(Map<String, dynamic> json) => _$NewsfeedDtoFromJson(json);
}
