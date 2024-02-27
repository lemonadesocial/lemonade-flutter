import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/event/entities/event_guest.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_invited_statistics.freezed.dart';
part 'event_invited_statistics.g.dart';

@freezed
class EventInvitedStatistics with _$EventInvitedStatistics {
  factory EventInvitedStatistics({
    @JsonKey(name: 'total') int? total,
    @JsonKey(name: 'total_joined') int? totalJoined,
    @JsonKey(name: 'top_inviter') String? topInviter,
    @JsonKey(name: 'top_inviter_expanded') UserDto? topInviterExpanded,
    @JsonKey(name: 'guests') List<EventGuest>? guests,
  }) = _EventInvitedStatistics;

  factory EventInvitedStatistics.fromJson(Map<String, dynamic> json) =>
      _$EventInvitedStatisticsFromJson(json);
}
