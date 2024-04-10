import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_profile_field_dto.freezed.dart';
part 'event_application_profile_field_dto.g.dart';

@freezed
class EventApplicationProfileFieldDto with _$EventApplicationProfileFieldDto {
  factory EventApplicationProfileFieldDto({
    String? field,
    bool? required,
  }) = _EventApplicationProfileFieldDto;

  factory EventApplicationProfileFieldDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EventApplicationProfileFieldDtoFromJson(json);
}
