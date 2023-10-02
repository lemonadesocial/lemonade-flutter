import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_payment_dto.freezed.dart';
part 'event_payment_dto.g.dart';

@freezed
class EventPaymentDto with _$EventPaymentDto {
  @JsonSerializable(explicitToJson: true)
  factory EventPaymentDto({
    @JsonKey(name: '_id') String? id,
    String? user,
    @JsonKey(name: 'ticket_type') String? ticketType,
    @JsonKey(name: 'ticket_count') double? ticketCount,
    @JsonKey(name: 'ticket_count_remaining') ticketCountRemaining,
    double? amount,
    @JsonKey(name: 'ticket_discount') String? ticketDiscount,
    @JsonKey(name: 'ticket_discount_amount') double? ticketDiscountAmount,
    @JsonKey(name: 'ticket_assignee_expanded')
    List<UserDto>? ticketAssigneesExpanded,
    @JsonKey(name: 'ticket_assigned_emails') List<String>? ticketAssignedEmails,
    @JsonKey(name: 'event_expanded') EventDto? eventExpanded,
  }) = _EventPaymentDto;

  factory EventPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentDtoFromJson(json);
}
