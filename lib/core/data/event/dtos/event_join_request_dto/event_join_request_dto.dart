import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_join_request_dto.freezed.dart';
part 'event_join_request_dto.g.dart';

@freezed
class EventJoinRequestDto with _$EventJoinRequestDto {
  @JsonSerializable(explicitToJson: true)
  factory EventJoinRequestDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? user,
    @JsonKey(name: 'decided_at') DateTime? decidedAt,
    @JsonKey(name: 'decided_by') String? decidedBy,
    @JsonKey(name: 'user_expanded') UserDto? userExpanded,
    @JsonKey(name: 'decided_by_expanded') UserDto? decidedByExpanded,
    @JsonKey(name: 'event_expanded') EventDto? eventExpanded,
    Enum$EventJoinRequestState? state,
  }) = _EventJoinRequestDto;

  factory EventJoinRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EventJoinRequestDtoFromJson(json);
}
