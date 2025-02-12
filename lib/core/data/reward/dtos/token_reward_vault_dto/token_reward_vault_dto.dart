import 'package:app/core/data/reward/dtos/reward_token_dto/reward_token_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_reward_vault_dto.freezed.dart';
part 'token_reward_vault_dto.g.dart';

@freezed
class TokenRewardVaultDto with _$TokenRewardVaultDto {
  factory TokenRewardVaultDto({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? network,
    String? address,
    List<RewardTokenDto>? tokens,
  }) = _TokenRewardVaultDto;

  factory TokenRewardVaultDto.fromJson(Map<String, dynamic> json) =>
      _$TokenRewardVaultDtoFromJson(json);
}
