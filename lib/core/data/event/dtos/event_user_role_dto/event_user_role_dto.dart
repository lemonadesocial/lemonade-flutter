import 'package:app/core/data/event/dtos/event_role_information_dto/event_role_information_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_user_role_dto.freezed.dart';
part 'event_user_role_dto.g.dart';

@freezed
class EventUserRoleDto with _$EventUserRoleDto {
  factory EventUserRoleDto({
    UserDto? user,
    @JsonKey(name: 'roles') List<EventRoleInformationDto>? roles,
    String? email,
  }) = _EventUserRoleDto;

  factory EventUserRoleDto.fromJson(Map<String, dynamic> json) =>
      _$EventUserRoleDtoFromJson(json);
}
