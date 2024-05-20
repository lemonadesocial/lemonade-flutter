import 'package:freezed_annotation/freezed_annotation.dart';

part 'farcaster_signed_key_request.g.dart';
part 'farcaster_signed_key_request.freezed.dart';

enum FarcasterSignedKeyRequestState {
  pending,
  completed,
}

@freezed
class FarcasterSignedKeyRequest with _$FarcasterSignedKeyRequest {
  factory FarcasterSignedKeyRequest({
    String? token,
    String? deeplinkUrl,
    String? key,
    int? requestFid,
    FarcasterSignedKeyRequestState? state,
    bool? isSponsored,
  }) = _FarcasterSignedKeyRequest;

  factory FarcasterSignedKeyRequest.fromJson(Map<String, dynamic> json) =>
      _$FarcasterSignedKeyRequestFromJson(json);
}
