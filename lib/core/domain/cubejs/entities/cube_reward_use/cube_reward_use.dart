import 'package:freezed_annotation/freezed_annotation.dart';

part 'cube_reward_use.freezed.dart';
part 'cube_reward_use.g.dart';

@freezed
class CubeRewardUse with _$CubeRewardUse {
  factory CubeRewardUse({
    @JsonKey(name: "EventRewardUses.rewardId") String? rewardId,
    @JsonKey(name: "EventRewardUses.updatedAt") DateTime? updatedAt,
    @JsonKey(name: "EventRewardUses.count") int? count,
  }) = _CubeRewardUse;

  factory CubeRewardUse.fromJson(Map<String, dynamic> json) =>
      _$CubeRewardUseFromJson(json);
}
