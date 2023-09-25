import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_dto.freezed.dart';
part 'event_ticket_dto.g.dart';

@freezed
class EventTicketDto with _$EventTicketDto {
  factory EventTicketDto({
    @JsonKey(name: '_id') String? id,
    bool? accepted,
    @JsonKey(name: 'assigned_email') String? assignedEmail,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    String? event,
    @JsonKey(name: 'invited_by') String? invitedBy,
    String? type,
  }) = _EventTicketDto;

  factory EventTicketDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketDtoFromJson(json);
}
