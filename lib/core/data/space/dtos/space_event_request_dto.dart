import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_event_request_dto.freezed.dart';
part 'space_event_request_dto.g.dart';

@freezed
class SpaceEventRequestDto with _$SpaceEventRequestDto {
  const factory SpaceEventRequestDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'created_by') String? createdBy,
    String? space,
    String? event,
    @JsonKey(name: 'event_expanded') EventDto? eventExpanded,
    List<String>? tags,
    Enum$SpaceEventRequestState? state,
    @JsonKey(name: 'decided_at') DateTime? decidedAt,
    @JsonKey(name: 'decided_by') String? decidedBy,
  }) = _SpaceEventRequestDto;

  factory SpaceEventRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceEventRequestDtoFromJson(json);
}
