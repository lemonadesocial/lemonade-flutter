import 'package:app/core/data/reward/dtos/ticket_type_reward_dto/ticket_type_reward_dto.dart';
import 'package:app/core/data/reward/dtos/token_reward_vault_dto/token_reward_vault_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_token_reward_setting_dto.freezed.dart';
part 'ticket_token_reward_setting_dto.g.dart';

@freezed
class TicketTokenRewardSettingDto with _$TicketTokenRewardSettingDto {
  factory TicketTokenRewardSettingDto({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? photo,
    String? vault,
    @JsonKey(name: 'currency_address') String? currencyAddress,
    String? event,
    List<TicketTypeRewardDto>? rewards,
    @JsonKey(name: 'vault_expanded') TokenRewardVaultDto? vaultExpanded,
  }) = _TicketTokenRewardSettingDto;

  factory TicketTokenRewardSettingDto.fromJson(Map<String, dynamic> json) =>
      _$TicketTokenRewardSettingDtoFromJson(json);
}
