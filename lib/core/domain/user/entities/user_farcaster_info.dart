import 'package:app/core/data/user/dtos/user_farcaster_info_dto/user_farcaster_info_dto.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_account_key_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_farcaster_info.freezed.dart';
part 'user_farcaster_info.g.dart';

@freezed
class UserFarcasterInfo with _$UserFarcasterInfo {
  const UserFarcasterInfo._();

  factory UserFarcasterInfo({
    FarcasterAccountKeyRequest? accountKeyRequest,
    double? fid,
  }) = _UserFarcasterInfo;

  factory UserFarcasterInfo.fromJson(Map<String, dynamic> json) =>
      _$UserFarcasterInfoFromJson(json);

  factory UserFarcasterInfo.fromDto(
    UserFarcasterInfoDto dto,
  ) =>
      UserFarcasterInfo(
        accountKeyRequest: dto.accountKeyRequest != null
            ? FarcasterAccountKeyRequest.fromDto(dto.accountKeyRequest!)
            : null,
        fid: dto.fid,
      );
}
