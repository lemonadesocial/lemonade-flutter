import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_cohost_request_dto.freezed.dart';
part 'event_cohost_request_dto.g.dart';

@freezed
class EventCohostRequestDto with _$EventCohostRequestDto {
  factory EventCohostRequestDto({
    @JsonKey(name: '_id') String? id,
    String? event,
    @JsonKey(name: 'to_expanded') UserDto? toExpanded,
    EventCohostRequestState? state,
  }) = _EventCohostRequestDto;

  factory EventCohostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EventCohostRequestDtoFromJson(json);
}
