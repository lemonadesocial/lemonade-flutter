import 'package:app/core/data/event/dtos/event_user_role_dto/event_user_role_dto.dart';
import 'package:app/core/domain/event/entities/event_role_information.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_user_role.g.dart';
part 'event_user_role.freezed.dart';

@freezed
class EventUserRole with _$EventUserRole {
  @JsonSerializable(explicitToJson: true)
  const factory EventUserRole({
    User? user,
    List<EventRoleInformation>? roles,
    String? email,
  }) = _EventUserRole;

  factory EventUserRole.fromDto(EventUserRoleDto dto) => EventUserRole(
        user: dto.user != null ? User.fromDto(dto.user!) : null,
        roles: List.from(dto.roles ?? [])
            .map((item) => EventRoleInformation.fromDto(item))
            .toList(),
        email: dto.email,
      );

  factory EventUserRole.fromJson(Map<String, dynamic> json) =>
      _$EventUserRoleFromJson(json);
}
