import 'package:app/core/data/farcaster/dtos/farcaster_account_key_request_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_farcaster_info_dto.freezed.dart';
part 'user_farcaster_info_dto.g.dart';

@freezed
class UserFarcasterInfoDto with _$UserFarcasterInfoDto {
  factory UserFarcasterInfoDto({
    @JsonKey(name: 'account_key_request')
    FarcasterAccountKeyRequestDto? accountKeyRequest,
    double? fid,
  }) = _UserFarcasterInfoDto;

  factory UserFarcasterInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserFarcasterInfoDtoFromJson(json);
}
