import 'package:app/core/data/event/dtos/event_application_profile_field_dto/event_application_profile_field_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_profile_field.freezed.dart';
part 'event_application_profile_field.g.dart';

@freezed
class EventApplicationProfileField with _$EventApplicationProfileField {
  factory EventApplicationProfileField({
    String? field,
    bool? required,
  }) = _EventApplicationProfileField;

  factory EventApplicationProfileField.fromDto(
    EventApplicationProfileFieldDto dto,
  ) =>
      EventApplicationProfileField(
        field: dto.field,
        required: dto.required,
      );
  factory EventApplicationProfileField.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationProfileFieldFromJson(json);
}
