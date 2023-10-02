import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/event/dtos/event_payment_ticket_type_dto/event_payment_ticket_type_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/event/event_enums.dart';
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
    List<String>? cohosts,
    @JsonKey(name: 'cohosts_expanded') List<UserDto?>? cohostsExpanded,
    String? title,
    String? slug,
    @JsonKey(name: 'speaker_users') List<String>? speakerUsers,
    String? host,
    List<BroadcastDto>? broadcasts,
    String? description,
    DateTime? start,
    DateTime? end,
    double? cost,
    Currency? currency,
    List<String>? accepted,
    List<String>? invited,
    List<String>? pending,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'matrix_event_room_id') String? matrixEventRoomId,
    @JsonKey(name: 'payment_ticket_types')
    List<EventPaymentTicketTypeDto>? paymentTicketTypes,
    List<EventOfferDto>? offers,
  }) = _EventDto;

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);
}

@freezed
class EventOfferDto with _$EventOfferDto {
  factory EventOfferDto({
    @JsonKey(name: '_id') String? id,
    bool? auto,
    @JsonKey(name: 'broadcast_rooms') List<String>? broadcastRooms,
    double? position,
    OfferProvider? provider,
    @JsonKey(name: 'provider_id') String? providerId,
    @JsonKey(name: 'provider_network') String? providerNetwork,
  }) = _EventOfferDto;

  factory EventOfferDto.fromJson(Map<String, dynamic> json) =>
      _$EventOfferDtoFromJson(json);
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
