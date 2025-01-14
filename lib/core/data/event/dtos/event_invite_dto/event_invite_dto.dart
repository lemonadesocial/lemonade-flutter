import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_invite_dto.freezed.dart';
part 'event_invite_dto.g.dart';

@freezed
class EventInviteDto with _$EventInviteDto {
  factory EventInviteDto({
    String? event,
    String? inviter,
    @JsonKey(name: 'event_expanded') EventDto? eventExpanded,
    @JsonKey(name: 'inviter_expanded') UserDto? inviterExpanded,
  }) = _EventInviteDto;

  factory EventInviteDto.fromJson(Map<String, dynamic> json) =>
      _$EventInviteDtoFromJson(json);
}

@freezed
class GetEventPendingInvitesResponseDto
    with _$GetEventPendingInvitesResponseDto {
  factory GetEventPendingInvitesResponseDto({
    @JsonKey(name: 'event_invites') List<EventInviteDto>? eventInvites,
    @JsonKey(name: 'cohost_requests') List<EventInviteDto>? cohostRequests,
  }) = _GetEventPendingInvitesResponseDto;

  factory GetEventPendingInvitesResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetEventPendingInvitesResponseDtoFromJson(json);
}
