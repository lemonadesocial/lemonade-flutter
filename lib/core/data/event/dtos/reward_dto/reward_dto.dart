import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_dto.freezed.dart';
part 'reward_dto.g.dart';

@freezed
class RewardDto with _$RewardDto {
  factory RewardDto({
    @JsonKey(name: '_id') String? id,
    bool? active,
    String? title,
    @JsonKey(name: 'icon_url') String? iconUrl,
    @JsonKey(name: 'icon_color') String? iconColor,
    @JsonKey(name: 'limit') int? limit,
    @JsonKey(name: 'limit_per') int? limitPer,
  }) = _RewardDto;

  factory RewardDto.fromJson(Map<String, dynamic> json) =>
      _$RewardDtoFromJson(json);
}
