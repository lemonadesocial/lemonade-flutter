import 'package:app/core/data/reward/dtos/token_reward_setting_dto/token_reward_setting_dto.dart';
import 'package:app/core/domain/reward/entities/ticket_type_reward.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_reward_setting.freezed.dart';
part 'token_reward_setting.g.dart';

@freezed
class TokenRewardSetting with _$TokenRewardSetting {
  factory TokenRewardSetting({
    String? id,
    String? title,
    String? photo,
    String? vault,
    String? currencyAddress,
    String? event,
    List<TicketTypeReward>? rewards,
    TokenRewardVault? vaultExpanded,
  }) = _TokenRewardSetting;

  factory TokenRewardSetting.fromDto(TokenRewardSettingDto dto) =>
      TokenRewardSetting(
        id: dto.id,
        title: dto.title,
        photo: dto.photo,
        vault: dto.vault,
        currencyAddress: dto.currencyAddress,
        event: dto.event,
        rewards: dto.rewards?.map((r) => TicketTypeReward.fromDto(r)).toList(),
        vaultExpanded: dto.vaultExpanded != null
            ? TokenRewardVault.fromDto(dto.vaultExpanded!)
            : null,
      );

  factory TokenRewardSetting.fromJson(Map<String, dynamic> json) =>
      _$TokenRewardSettingFromJson(json);
}
