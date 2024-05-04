import 'package:app/core/data/event/dtos/reward_dto/reward_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward.freezed.dart';
part 'reward.g.dart';

@freezed
class Reward with _$Reward {
  factory Reward({
    String? id,
    bool? active,
    String? title,
    String? iconUrl,
    String? iconColor,
    int? limit,
    int? limitPer,
    List<String>? paymentTicketTypes,
  }) = _Reward;

  factory Reward.fromDto(RewardDto dto) => Reward(
        id: dto.id,
        active: dto.active,
        title: dto.title,
        iconUrl: dto.iconUrl,
        iconColor: dto.iconColor,
        limit: dto.limit,
        limitPer: dto.limitPer,
        paymentTicketTypes: dto.paymentTicketTypes,
      );
  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
}
