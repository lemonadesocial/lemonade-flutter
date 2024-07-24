import 'package:app/core/data/event/dtos/sub_event_settings_dto/sub_event_settings_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_event_settings.freezed.dart';
part 'sub_event_settings.g.dart';

@freezed
class SubEventSettings with _$SubEventSettings {
  const SubEventSettings._();

  factory SubEventSettings({
    bool? ticketRequiredForCreation,
    bool? ticketRequiredForPurchase,
  }) = _SubEventSettings;

  factory SubEventSettings.fromDto(SubEventSettingsDto dto) => SubEventSettings(
        ticketRequiredForCreation: dto.ticketRequiredForCreation,
        ticketRequiredForPurchase: dto.ticketRequiredForPurchase,
      );

  factory SubEventSettings.fromJson(Map<String, dynamic> json) =>
      _$SubEventSettingsFromJson(json);
}
