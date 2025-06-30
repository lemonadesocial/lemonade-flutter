import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'lens_account.freezed.dart';
part 'lens_account.g.dart';

@freezed
class LensAccount with _$LensAccount {
  const LensAccount._();

  @JsonSerializable(explicitToJson: true)
  const factory LensAccount({
    String? address,
    String? owner,
    String? createdAt,
    LensAccountMetadata? metadata,
    LensAccountUsername? username,
  }) = _LensAccount;

  String? get name => metadata?.name;
  String? get bio => metadata?.bio;
  String? get picture => metadata?.picture;

  String? get website => metadata?.findAttributeByKey('website')?.value;
  String? get handleTwitter =>
      metadata?.findAttributeByKey('handle_twitter')?.value;
  String? get handleFarcaster =>
      metadata?.findAttributeByKey('handle_farcaster')?.value;
  String? get handleInstagram =>
      metadata?.findAttributeByKey('handle_instagram')?.value;
  String? get handleGithub =>
      metadata?.findAttributeByKey('handle_github')?.value;
  String? get handleLens => metadata?.findAttributeByKey('handle_lens')?.value;
  String? get handleLinkedin =>
      metadata?.findAttributeByKey('handle_linkedin')?.value;
  String? get handleMirror =>
      metadata?.findAttributeByKey('handle_mirror')?.value;
  String? get handleFacebook =>
      metadata?.findAttributeByKey('handle_facebook')?.value;
  String? get calendlyUrl =>
      metadata?.findAttributeByKey('calendly_url')?.value;
  String? get jobTitle => metadata?.findAttributeByKey('job_title')?.value;
  String? get companyName =>
      metadata?.findAttributeByKey('company_name')?.value;
  String? get pronoun => metadata?.findAttributeByKey('pronoun')?.value;

  factory LensAccount.fromJson(Map<String, dynamic> json) =>
      _$LensAccountFromJson(json);
}

@freezed
class LensAccountMetadata with _$LensAccountMetadata {
  const LensAccountMetadata._();

  @JsonSerializable(explicitToJson: true)
  const factory LensAccountMetadata({
    String? id,
    String? name,
    String? bio,
    String? picture,
    String? coverPicture,
    List<LensMetadataAttribute>? attributes,
  }) = _LensAccountMetadata;

  factory LensAccountMetadata.fromJson(Map<String, dynamic> json) =>
      _$LensAccountMetadataFromJson(json);

  LensMetadataAttribute? findAttributeByKey(String key) {
    return attributes?.firstWhereOrNull(
      (attribute) => attribute.key == key,
    );
  }
}

@freezed
class LensMetadataAttribute with _$LensMetadataAttribute {
  const LensMetadataAttribute._();

  @JsonSerializable(explicitToJson: true)
  const factory LensMetadataAttribute({
    Enum$MetadataAttributeType? type,
    String? key,
    dynamic value,
  }) = _LensMetadataAttribute;

  factory LensMetadataAttribute.fromJson(Map<String, dynamic> json) =>
      _$LensMetadataAttributeFromJson(json);
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
