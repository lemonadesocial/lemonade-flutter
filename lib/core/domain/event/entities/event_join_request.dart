import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_join_request.freezed.dart';

@freezed
class EventJoinRequest with _$EventJoinRequest {
  EventJoinRequest._();

  factory EventJoinRequest({
    String? id,
    DateTime? createdAt,
    String? user,
    DateTime? decidedAt,
    String? decidedBy,
    User? userExpanded,
    User? decidedByExpanded,
    Event? eventExpanded,
    Enum$EventJoinRequestState? state,
  }) = _EventJoinRequest;

  factory EventJoinRequest.fromDto(EventJoinRequestDto dto) => EventJoinRequest(
        id: dto.id,
        createdAt: dto.createdAt,
        user: dto.user,
        decidedAt: dto.decidedAt,
        decidedBy: dto.decidedBy,
        userExpanded:
            dto.userExpanded != null ? User.fromDto(dto.userExpanded!) : null,
        decidedByExpanded: dto.decidedByExpanded != null
            ? User.fromDto(dto.decidedByExpanded!)
            : null,
        eventExpanded: dto.eventExpanded != null
            ? Event.fromDto(dto.eventExpanded!)
            : null,
        state: dto.state,
      );

  bool get isPending =>
      state == Enum$EventJoinRequestState.pending ||
      state == Enum$EventJoinRequestState.$unknown;

  bool get isDeclined => state == Enum$EventJoinRequestState.declined;

  bool get isApproved => state == Enum$EventJoinRequestState.approved;
}
