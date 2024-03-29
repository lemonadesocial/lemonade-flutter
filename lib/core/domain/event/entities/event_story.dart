import 'package:app/core/data/event/dtos/event_story_dto/event_story_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_story.freezed.dart';

@freezed
class EventStory with _$EventStory {
  const EventStory._();

  factory EventStory({
    String? id,
    String? url,
    String? owner,
    String? bucket,
    User? ownerExpanded,
    String? stamp,
    double? likes,
    bool? liked,
    String? description,
    String? key,
    String? type,
  }) = _EventStory;

  factory EventStory.fromDto(EventStoryDto dto) => EventStory(
        id: dto.id,
        url: dto.url,
        owner: dto.owner,
        bucket: dto.bucket,
        ownerExpanded:
            dto.ownerExpanded != null ? User.fromDto(dto.ownerExpanded!) : null,
        stamp: dto.stamp,
        likes: dto.likes,
        liked: dto.liked,
        description: dto.description,
        key: dto.key,
        type: dto.type,
      );
}
