import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_account.freezed.dart';
part 'lens_account.g.dart';

@freezed
class LensAccount with _$LensAccount {
  @JsonSerializable(explicitToJson: true)
  const factory LensAccount({
    String? address,
    String? owner,
    String? createdAt,
    LensAccountMetadata? metadata,
    LensAccountUsername? username,
  }) = _LensAccount;

  factory LensAccount.fromJson(Map<String, dynamic> json) =>
      _$LensAccountFromJson(json);
}

@freezed
class LensAccountMetadata with _$LensAccountMetadata {
  @JsonSerializable(explicitToJson: true)
  const factory LensAccountMetadata({
    String? id,
    String? name,
    String? bio,
    String? picture,
    String? coverPicture,
  }) = _LensAccountMetadata;

  factory LensAccountMetadata.fromJson(Map<String, dynamic> json) =>
      _$LensAccountMetadataFromJson(json);
}

@freezed
class LensAccountUsername with _$LensAccountUsername {
  @JsonSerializable(explicitToJson: true)
  const factory LensAccountUsername({
    String? id,
    String? linkedTo,
    String? localName,
    String? namespace,
    String? ownedBy,
    String? timestamp,
    String? value,
  }) = _LensAccountUsername;

  factory LensAccountUsername.fromJson(Map<String, dynamic> json) =>
      _$LensAccountUsernameFromJson(json);
}
