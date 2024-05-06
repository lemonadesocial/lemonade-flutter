import 'package:app/core/data/event/dtos/event_session/event_session_dto.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_session.freezed.dart';
part 'event_session.g.dart';

@freezed
class EventSession with _$EventSession {
  const EventSession._();

  @JsonSerializable(explicitToJson: true)
  factory EventSession({
    String? id,
    String? title,
    String? description,
    DateTime? start,
    DateTime? end,
    List<DbFile?>? photosExpanded,
    List<User?>? speakerUsersExpanded,
  }) = _EventSession;

  factory EventSession.fromDto(EventSessionDto dto) => EventSession(
        id: dto.id,
        title: dto.title,
        description: dto.description,
        start: dto.start,
        end: dto.end,
        photosExpanded: (dto.photosExpanded ?? [])
            .map((i) => i == null ? null : DbFile.fromDto(i))
            .toList(),
        speakerUsersExpanded: (dto.speakerUsersExpanded ?? [])
            .map((i) => i == null ? null : User.fromDto(i))
            .toList(),
      );

  factory EventSession.fromJson(Map<String, dynamic> json) =>
      _$EventSessionFromJson(json);
}
