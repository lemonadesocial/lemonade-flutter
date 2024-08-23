// import 'package:app/core/data/event/dtos/event_role_information_dto/event_role_information_dto.dart';
// import 'package:app/core/domain/event/entities/event_role.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'event_role_information.g.dart';
// part 'event_role_information.freezed.dart';

// @freezed
// class EventRoleInformation with _$EventRoleInformation {
//   @JsonSerializable(explicitToJson: true)
//   const factory EventRoleInformation({
//     EventRole? roleExpanded,
//     bool? visible,
//   }) = _EventRoleInformation;

//   factory EventRoleInformation.fromDto(EventRoleInformationDto dto) =>
//       EventRoleInformation(
//         roleExpanded: dto.roleExpanded != null
//             ? EventRole.fromDto(dto.roleExpanded!)
//             : null,
//         visible: dto.visible,
//       );

//   factory EventRoleInformation.fromJson(Map<String, dynamic> json) =>
//       _$EventRoleInformationFromJson(json);
// }
