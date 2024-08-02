import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_user_role.g.dart';
part 'event_user_role.freezed.dart';

@freezed
class EventUserRole with _$EventUserRole {
  @JsonSerializable(explicitToJson: true)
  const factory EventUserRole({
    User? user,
    List<EventRole>? roles,
  }) = _EventUserRole;

  factory EventUserRole.fromJson(Map<String, dynamic> json) =>
      _$EventUserRoleFromJson(json);
}
