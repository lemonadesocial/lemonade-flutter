import 'package:app/core/data/farcaster/dtos/farcaster_account_key_request_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'farcaster_account_key_request.freezed.dart';
part 'farcaster_account_key_request.g.dart';

@freezed
class FarcasterAccountKeyRequest with _$FarcasterAccountKeyRequest {
  const FarcasterAccountKeyRequest._();

  factory FarcasterAccountKeyRequest({
    bool? accepted,
    String? deeplinkUrl,
    String? token,
  }) = _FarcasterAccountKeyRequest;

  factory FarcasterAccountKeyRequest.fromJson(Map<String, dynamic> json) =>
      _$FarcasterAccountKeyRequestFromJson(json);

  factory FarcasterAccountKeyRequest.fromDto(
    FarcasterAccountKeyRequestDto dto,
  ) =>
      FarcasterAccountKeyRequest(
        accepted: dto.accepted,
        deeplinkUrl: dto.deeplinkUrl,
        token: dto.token,
      );
}
