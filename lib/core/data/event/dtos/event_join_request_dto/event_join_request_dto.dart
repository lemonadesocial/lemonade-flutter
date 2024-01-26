import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_join_request_dto.freezed.dart';
part 'event_join_request_dto.g.dart';

@freezed
class EventJoinRequestDto with _$EventJoinRequestDto {
  @JsonSerializable(explicitToJson: true)
  factory EventJoinRequestDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,
    @JsonKey(name: 'declined_at') DateTime? declinedAt,
    String? user,
    @JsonKey(name: 'declined_by') String? declinedBy,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'user_expanded') UserDto? userExpanded,
    @JsonKey(name: 'declined_by_expanded') UserDto? declinedByExpanded,
    @JsonKey(name: 'approved_by_expanded') UserDto? approvedByExpanded,
    @JsonKey(name: 'payment_expanded') PaymentDto? paymentExpanded,
    @JsonKey(name: 'event_expanded') EventDto? eventExpanded,
    @JsonKey(name: 'ticket_info') List<TicketInfoDto>? ticketInfo,
  }) = _EventJoinRequestDto;

  factory EventJoinRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EventJoinRequestDtoFromJson(json);
}
