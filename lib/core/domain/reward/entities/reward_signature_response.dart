import 'package:app/core/data/reward/dtos/reward_signature_response_dto/reward_signature_response_dto.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_signature_response.freezed.dart';
part 'reward_signature_response.g.dart';

@freezed
class RewardSignatureResponse with _$RewardSignatureResponse {
  factory RewardSignatureResponse({
    List<TokenRewardSetting>? settings,
    TokenRewardSignature? signature,
  }) = _RewardSignatureResponse;

  factory RewardSignatureResponse.fromDto(
    RewardSignatureResponseDto dto,
  ) =>
      RewardSignatureResponse(
        settings:
            dto.settings?.map((s) => TokenRewardSetting.fromDto(s)).toList(),
        signature: dto.signature != null
            ? TokenRewardSignature.fromDto(dto.signature!)
            : null,
      );

  factory RewardSignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$RewardSignatureResponseFromJson(json);
}

@freezed
class TokenRewardSignature with _$TokenRewardSignature {
  factory TokenRewardSignature({
    String? claimId,
    String? signature,
    List<dynamic>? args,
  }) = _TokenRewardSignature;

  factory TokenRewardSignature.fromDto(TokenRewardSignatureDto dto) =>
      TokenRewardSignature(
        claimId: dto.claimId,
        signature: dto.signature,
        args: dto.args,
      );

  factory TokenRewardSignature.fromJson(Map<String, dynamic> json) =>
      _$TokenRewardSignatureFromJson(json);
}
