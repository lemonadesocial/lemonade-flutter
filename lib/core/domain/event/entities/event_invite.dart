import 'package:app/core/data/event/dtos/event_invite_dto/event_invite_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_invite.freezed.dart';
part 'event_invite.g.dart';

@freezed
class EventInvite with _$EventInvite {
  const factory EventInvite({
    String? event,
    String? inviter,
    Event? eventExpanded,
    User? inviterExpanded,
  }) = _EventInvite;

  factory EventInvite.fromDto(EventInviteDto dto) {
    return EventInvite(
      event: dto.event,
      inviter: dto.inviter,
      eventExpanded:
          dto.eventExpanded != null ? Event.fromDto(dto.eventExpanded!) : null,
      inviterExpanded: dto.inviterExpanded != null
          ? User.fromDto(dto.inviterExpanded!)
          : null,
    );
  }
  factory EventInvite.fromJson(Map<String, dynamic> json) =>
      _$EventInviteFromJson(json);
}

@freezed
class GetEventPendingInvitesResponse with _$GetEventPendingInvitesResponse {
  const factory GetEventPendingInvitesResponse({
    List<EventInvite>? eventInvites,
    List<EventInvite>? cohostRequests,
  }) = _GetEventPendingInvitesResponse;

  factory GetEventPendingInvitesResponse.fromDto(
    GetEventPendingInvitesResponseDto dto,
  ) {
    return GetEventPendingInvitesResponse(
      eventInvites:
          dto.eventInvites?.map((e) => EventInvite.fromDto(e)).toList(),
      cohostRequests:
          dto.cohostRequests?.map((e) => EventInvite.fromDto(e)).toList(),
    );
  }

  factory GetEventPendingInvitesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetEventPendingInvitesResponseFromJson(json);
}
