import 'package:app/core/data/reward/dtos/token_reward_setting_dto/token_reward_setting_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_signature_response_dto.freezed.dart';
part 'reward_signature_response_dto.g.dart';

@freezed
class RewardSignatureResponseDto with _$RewardSignatureResponseDto {
  factory RewardSignatureResponseDto({
    List<TokenRewardSettingDto>? settings,
    TokenRewardSignatureDto? signature,
  }) = _RewardSignatureResponseDto;

  factory RewardSignatureResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RewardSignatureResponseDtoFromJson(json);
}

@freezed
class TokenRewardSignatureDto with _$TokenRewardSignatureDto {
  factory TokenRewardSignatureDto({
    String? claimId,
    String? signature,
    List<dynamic>? args,
  }) = _TokenRewardSignatureDto;

  factory TokenRewardSignatureDto.fromJson(Map<String, dynamic> json) =>
      _$TokenRewardSignatureDtoFromJson(json);
}
