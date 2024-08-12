import 'package:app/core/data/event/dtos/event_user_role_dto/event_user_role_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_role_information_dto.freezed.dart';
part 'event_role_information_dto.g.dart';

@freezed
class EventRoleInformationDto with _$EventRoleInformationDto {
  factory EventRoleInformationDto({
    @JsonKey(name: 'role_expanded') List<EventUserRoleDto>? roleExpanded,
    bool? visible,
  }) = _EventRoleInformationDto;

  factory EventRoleInformationDto.fromJson(Map<String, dynamic> json) =>
      _$EventRoleInformationDtoFromJson(json);
}
