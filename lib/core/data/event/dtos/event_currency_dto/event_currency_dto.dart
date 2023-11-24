import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_currency_dto.freezed.dart';
part 'event_currency_dto.g.dart';

@freezed
class EventCurrencyDto with _$EventCurrencyDto {
  factory EventCurrencyDto({
    double? decimals,
    String? currency,
    String? network,
  }) = _EventCurrencyDto;

  factory EventCurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$EventCurrencyDtoFromJson(json);
}
