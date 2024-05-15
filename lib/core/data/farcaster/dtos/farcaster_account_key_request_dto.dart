import 'package:freezed_annotation/freezed_annotation.dart';

part 'farcaster_account_key_request_dto.freezed.dart';
part 'farcaster_account_key_request_dto.g.dart';

@freezed
class FarcasterAccountKeyRequestDto with _$FarcasterAccountKeyRequestDto {
  factory FarcasterAccountKeyRequestDto({
    bool? accepted,
    @JsonKey(name: 'deeplink_url') String? deeplinkUrl,
    String? token,
  }) = _FarcasterAccountKeyRequestDto;

  factory FarcasterAccountKeyRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FarcasterAccountKeyRequestDtoFromJson(json);
}
