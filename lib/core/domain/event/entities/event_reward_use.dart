import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_reward_use.freezed.dart';
part 'event_reward_use.g.dart';

@freezed
class EventRewardUse with _$EventRewardUse {
  factory EventRewardUse({
    String? id,
    bool? active,
    String? event,
    String? rewardId,
    double? rewardNumber,
    String? user,
  }) = _EventRewardUse;

  factory EventRewardUse.fromJson(Map<String, dynamic> json) =>
      _$EventRewardUseFromJson(json);
}
