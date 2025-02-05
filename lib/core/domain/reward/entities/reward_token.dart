import 'package:app/core/data/reward/dtos/reward_token_dto/reward_token_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_token.freezed.dart';
part 'reward_token.g.dart';

@freezed
class RewardToken with _$RewardToken {
  factory RewardToken({
    String? address,
    String? symbol,
    String? name,
    int? decimals,
    String? icon,
    String? iconUrl,
  }) = _RewardToken;

  factory RewardToken.fromDto(RewardTokenDto dto) => RewardToken(
        address: dto.address,
        symbol: dto.symbol,
        name: dto.name,
        decimals: dto.decimals,
        icon: dto.icon,
        iconUrl: dto.iconUrl,
      );

  factory RewardToken.fromJson(Map<String, dynamic> json) =>
      _$RewardTokenFromJson(json);
}
