import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_dtos.freezed.dart';
part 'event_dtos.g.dart';

@freezed
class EventDto with _$EventDto {
  @JsonSerializable(explicitToJson: true)
  factory EventDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'host_expanded') UserDto? hostExpanded,
    @JsonKey(name: 'new_new_photos_expanded')
    List<DbFileDto?>? newNewPhotosExpanded,
    @JsonKey(name: 'cohosts_expanded') List<UserDto?>? cohostsExpanded,
    String? title,
    String? slug,
    String? host,
    List<BroadcastDto>? broadcasts,
    String? description,
    DateTime? start,
    DateTime? end,
    double? cost,
    Currency? currency,
    List<String>? accepted,
  }) = _EventDto;

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);
}

@freezed
class BroadcastDto with _$BroadcastDto {
  @JsonSerializable(explicitToJson: true)
  factory BroadcastDto({
    @JsonKey(name: 'provider_id', includeIfNull: false) String? providerId,
  }) = _BroadcastDto;

  factory BroadcastDto.fromJson(Map<String, dynamic> json) =>
      _$BroadcastDtoFromJson(json);
}
