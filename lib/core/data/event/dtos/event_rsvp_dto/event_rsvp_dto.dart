import 'package:app/core/domain/event/event_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_rsvp_dto.freezed.dart';
part 'event_rsvp_dto.g.dart';

@freezed
class EventRsvpDto with _$EventRsvpDto {
  @JsonSerializable(
    explicitToJson: true,
  )
  const factory EventRsvpDto({
    @JsonKey(name: '_id') String? id,
    EventRsvpMessagesDto? messages,
    EventRsvpPaymentDto? payment,
    EventRsvpState? state,
  }) = _EventRSVPDto;

  factory EventRsvpDto.fromJson(Map<String, dynamic> json) =>
      _$EventRsvpDtoFromJson(json);
}

@freezed
class EventRsvpMessagesDto with _$EventRsvpMessagesDto {
  factory EventRsvpMessagesDto({
    String? primary,
    String? secondary,
  }) = _EventRsvpMessagesDto;

  factory EventRsvpMessagesDto.fromJson(Map<String, dynamic> json) =>
      _$EventRsvpMessagesDtoFromJson(json);
}

@freezed
class EventRsvpPaymentDto with _$EventRsvpPaymentDto {
  factory EventRsvpPaymentDto({
    double? amount,
    String? currency,
    String? provider,
  }) = _EventRsvpPaymentDto;

  factory EventRsvpPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$EventRsvpPaymentDtoFromJson(json);
}
