import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_session_dto.freezed.dart';
part 'event_session_dto.g.dart';

@freezed
class EventSessionDto with _$EventSessionDto {
  factory EventSessionDto({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? description,
    DateTime? start,
    DateTime? end,
    @JsonKey(name: 'photos_expanded') List<DbFileDto?>? photosExpanded,
    @JsonKey(name: 'speaker_users_expanded')
    List<UserDto?>? speakerUsersExpanded,
  }) = _EventSessionDto;

  factory EventSessionDto.fromJson(Map<String, dynamic> json) =>
      _$EventSessionDtoFromJson(json);
}
