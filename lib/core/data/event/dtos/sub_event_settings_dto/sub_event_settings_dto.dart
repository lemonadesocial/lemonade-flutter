import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_event_settings_dto.freezed.dart';
part 'sub_event_settings_dto.g.dart';

@freezed
class SubEventSettingsDto with _$SubEventSettingsDto {
  factory SubEventSettingsDto({
    @JsonKey(name: 'ticket_required_for_creation')
    bool? ticketRequiredForCreation,
    @JsonKey(name: 'ticket_required_for_purchase')
    bool? ticketRequiredForPurchase,
  }) = _SubEventSettingsDto;

  factory SubEventSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SubEventSettingsDtoFromJson(json);
}
