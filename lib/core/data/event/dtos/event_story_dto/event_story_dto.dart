import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_story_dto.freezed.dart';
part 'event_story_dto.g.dart';

@freezed
class EventStoryDto with _$EventStoryDto {
  factory EventStoryDto({
    @JsonKey(name: '_id', includeIfNull: false) String? id,
    String? url,
    String? owner,
    String? bucket,
    @JsonKey(name: 'owner_expanded') UserDto? ownerExpanded,
    String? stamp,
    double? likes,
    bool? liked,
    String? description,
    String? key,
    String? type,
  }) = _EventStoryDto;

  factory EventStoryDto.fromJson(Map<String, dynamic> json) =>
      _$EventStoryDtoFromJson(json);
}
