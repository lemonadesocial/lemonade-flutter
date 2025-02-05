import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_type_reward_dto.freezed.dart';
part 'ticket_type_reward_dto.g.dart';

@freezed
class TicketTypeRewardDto with _$TicketTypeRewardDto {
  factory TicketTypeRewardDto({
    @JsonKey(name: 'ticket_type') String? ticketType,
    @JsonKey(name: 'reward_per_ticket') String? rewardPerTicket,
  }) = _TicketTypeRewardDto;

  factory TicketTypeRewardDto.fromJson(Map<String, dynamic> json) =>
      _$TicketTypeRewardDtoFromJson(json);
}
