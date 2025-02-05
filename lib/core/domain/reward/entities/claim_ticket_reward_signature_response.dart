import 'package:app/core/data/reward/dtos/claim_ticket_reward_signature_response_dto/claim_ticket_reward_signature_response_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_ticket_reward_signature_response.freezed.dart';
part 'claim_ticket_reward_signature_response.g.dart';

@freezed
class ClaimTicketRewardSignatureResponse
    with _$ClaimTicketRewardSignatureResponse {
  factory ClaimTicketRewardSignatureResponse({
    String? signature,
    String? message,
    String? network,
    String? vault,
    String? currency,
    String? amount,
  }) = _ClaimTicketRewardSignatureResponse;

  factory ClaimTicketRewardSignatureResponse.fromDto(
    ClaimTicketRewardSignatureResponseDto dto,
  ) =>
      ClaimTicketRewardSignatureResponse(
        signature: dto.signature,
        message: dto.message,
        network: dto.network,
        vault: dto.vault,
        currency: dto.currency,
        amount: dto.amount,
      );

  factory ClaimTicketRewardSignatureResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ClaimTicketRewardSignatureResponseFromJson(json);
}
