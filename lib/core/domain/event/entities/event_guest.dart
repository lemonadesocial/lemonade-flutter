import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_guest.freezed.dart';
part 'event_guest.g.dart';

@freezed
class EventGuest with _$EventGuest {
  factory EventGuest({
    @JsonKey(name: 'invited_by') String? invitedBy,
    @JsonKey(name: 'invited_by_expanded') UserDto? invitedByExpanded,
    @JsonKey(name: 'joined') bool? joined,
    @JsonKey(name: 'user') String? user,
    @JsonKey(name: 'user_expanded') UserDto? userExpanded,
    @JsonKey(name: 'email') String? email,
  }) = _EventGuest;

  factory EventGuest.fromJson(Map<String, dynamic> json) =>
      _$EventGuestFromJson(json);
}
