import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_token_dto.freezed.dart';
part 'reward_token_dto.g.dart';

@freezed
class RewardTokenDto with _$RewardTokenDto {
  factory RewardTokenDto({
    String? address,
    String? symbol,
    String? name,
    int? decimals,
    String? icon,
    @JsonKey(name: 'icon_url') String? iconUrl,
  }) = _RewardTokenDto;

  factory RewardTokenDto.fromJson(Map<String, dynamic> json) =>
      _$RewardTokenDtoFromJson(json);
}
