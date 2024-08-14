import 'package:app/core/data/event/dtos/event_feature_dto/event_feature_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_role_dto.freezed.dart';
part 'event_role_dto.g.dart';

@freezed
class EventRoleDto with _$EventRoleDto {
  factory EventRoleDto({
    @JsonKey(name: '_id') String? id,
    Enum$RoleCode? code,
    String? title,
    @JsonKey(name: 'features_expanded') List<EventFeatureDto>? featuresExpanded,
  }) = _EventRoleDto;

  factory EventRoleDto.fromJson(Map<String, dynamic> json) =>
      _$EventRoleDtoFromJson(json);
}
