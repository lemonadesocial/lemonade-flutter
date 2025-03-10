import 'package:app/core/data/space/dtos/space_event_request_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_event_request.freezed.dart';
part 'space_event_request.g.dart';

@freezed
class SpaceEventRequest with _$SpaceEventRequest {
  const factory SpaceEventRequest({
    String? id,
    Enum$SpaceEventRequestState? state,
    List<String>? tags,
    String? event,
    Event? eventExpanded,
    String? space,
    DateTime? createdAt,
    String? createdBy,
    DateTime? decidedAt,
    String? decidedBy,
  }) = _SpaceEventRequest;

  factory SpaceEventRequest.fromJson(Map<String, dynamic> json) =>
      _$SpaceEventRequestFromJson(json);

  factory SpaceEventRequest.fromDto(SpaceEventRequestDto dto) {
    return SpaceEventRequest(
      id: dto.id,
      state: dto.state,
      tags: dto.tags,
      space: dto.space,
      event: dto.event,
      eventExpanded:
          dto.eventExpanded != null ? Event.fromDto(dto.eventExpanded!) : null,
      createdAt: dto.createdAt,
      createdBy: dto.createdBy,
      decidedAt: dto.decidedAt,
      decidedBy: dto.decidedBy,
    );
  }
}
