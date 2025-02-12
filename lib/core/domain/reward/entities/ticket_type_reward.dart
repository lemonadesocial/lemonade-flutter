import 'package:app/core/data/reward/dtos/ticket_type_reward_dto/ticket_type_reward_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_type_reward.freezed.dart';
part 'ticket_type_reward.g.dart';

@freezed
class TicketTypeReward with _$TicketTypeReward {
  factory TicketTypeReward({
    String? ticketType,
    String? rewardPerTicket,
  }) = _TicketTypeReward;

  factory TicketTypeReward.fromDto(TicketTypeRewardDto dto) => TicketTypeReward(
        ticketType: dto.ticketType,
        rewardPerTicket: dto.rewardPerTicket,
      );

  factory TicketTypeReward.fromJson(Map<String, dynamic> json) =>
      _$TicketTypeRewardFromJson(json);
}
