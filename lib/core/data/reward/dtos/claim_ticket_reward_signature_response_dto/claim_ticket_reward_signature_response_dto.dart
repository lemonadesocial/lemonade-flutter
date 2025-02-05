import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_ticket_reward_signature_response_dto.freezed.dart';
part 'claim_ticket_reward_signature_response_dto.g.dart';

@freezed
class ClaimTicketRewardSignatureResponseDto
    with _$ClaimTicketRewardSignatureResponseDto {
  factory ClaimTicketRewardSignatureResponseDto({
    String? signature,
    String? message,
    String? network,
    String? vault,
    String? currency,
    String? amount,
  }) = _ClaimTicketRewardSignatureResponseDto;

  factory ClaimTicketRewardSignatureResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ClaimTicketRewardSignatureResponseDtoFromJson(json);
}
