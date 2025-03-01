import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_dto.freezed.dart';
part 'ticket_dto.g.dart';

@freezed
class TicketDto with _$TicketDto {
  factory TicketDto({
    @JsonKey(name: '_id') required String id,
    required String shortid,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String event,
    required String type,
    bool? accepted,
    @JsonKey(name: 'acquired_by') String? acquiredBy,
    @JsonKey(name: 'cancelled_by') String? cancelledBy,
    @JsonKey(name: 'acquired_by_email') String? acquiredByEmail,
    @JsonKey(name: 'assigned_email') String? assignedEmail,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'invited_by') String? invitedBy,
    @JsonKey(name: 'payment_id') String? paymentId,
    Map<String, dynamic>? metadata,
    @JsonKey(name: 'assigned_to_info') Map<String, dynamic>? assignedToInfo,
    @JsonKey(name: 'assigned_to_expanded') UserDto? assignedToExpanded,
    @JsonKey(name: 'event_expanded') EventDto? eventExpanded,
    @JsonKey(name: 'type_expanded') EventTicketTypeDto? typeExpanded,
    @JsonKey(name: 'acquired_tickets') List<TicketDto>? acquiredTickets,
  }) = _TicketDto;

  factory TicketDto.fromJson(Map<String, dynamic> json) =>
      _$TicketDtoFromJson(json);
}
