// import 'package:app/core/data/event/dtos/event_role_dto/event_role_dto.dart';
// import 'package:app/core/domain/event/entities/event_feature.dart';
// import 'package:app/graphql/backend/schema.graphql.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'event_role.g.dart';
// part 'event_role.freezed.dart';

// @freezed
// class EventRole with _$EventRole {
//   @JsonSerializable(explicitToJson: true)
//   const factory EventRole({
//     String? id,
//     Enum$RoleCode? code,
//     String? title,
//     List<EventFeature?>? featuresExpanded,
//   }) = _EventRole;

//   factory EventRole.fromDto(EventRoleDto dto) {
//     return EventRole(
//       id: dto.id,
//       code: dto.code,
//       title: dto.title,
//       featuresExpanded: dto.featuresExpanded != null
//           ? List.from(dto.featuresExpanded ?? [])
//               .map((item) => EventFeature.fromDto(item))
//               .toList()
//           : [],
//     );
//   }

//   factory EventRole.fromJson(Map<String, dynamic> json) =>
//       _$EventRoleFromJson(json);
// }
