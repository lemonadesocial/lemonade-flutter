import 'package:app/core/data/reward/dtos/token_reward_vault_dto/token_reward_vault_dto.dart';
import 'package:app/core/domain/reward/entities/reward_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_reward_vault.freezed.dart';
part 'token_reward_vault.g.dart';

@freezed
class TokenRewardVault with _$TokenRewardVault {
  TokenRewardVault._();

  factory TokenRewardVault({
    String? id,
    String? title,
    String? network,
    String? address,
    List<RewardToken>? tokens,
  }) = _TokenRewardVault;

  factory TokenRewardVault.fromDto(TokenRewardVaultDto dto) => TokenRewardVault(
        id: dto.id,
        title: dto.title,
        network: dto.network,
        address: dto.address,
        tokens: dto.tokens?.map((t) => RewardToken.fromDto(t)).toList(),
      );

  factory TokenRewardVault.fromJson(Map<String, dynamic> json) =>
      _$TokenRewardVaultFromJson(json);

  // Custom equality based on id and address
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TokenRewardVault &&
        other.id == id &&
        other.address == address;
  }

  @override
  int get hashCode => Object.hash(id, address);
}
