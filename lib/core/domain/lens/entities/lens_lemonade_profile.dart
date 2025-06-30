import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'lens_lemonade_profile.freezed.dart';
part 'lens_lemonade_profile.g.dart';

@freezed
class LensLemonadeProfile with _$LensLemonadeProfile {
  const LensLemonadeProfile._();

  factory LensLemonadeProfile({
    @JsonKey(name: 'image_avatar') String? imageAvatar,
    String? name,
    String? description,
    String? website,
    @JsonKey(name: 'job_title') String? jobTitle,
    @JsonKey(name: 'company_name') String? companyName,
    String? pronoun,
    @JsonKey(name: 'handle_twitter') String? handleTwitter,
    @JsonKey(name: 'handle_farcaster') String? handleFarcaster,
    @JsonKey(name: 'handle_instagram') String? handleInstagram,
    @JsonKey(name: 'handle_github') String? handleGithub,
    @JsonKey(name: 'handle_lens') String? handleLens,
    @JsonKey(name: 'handle_linkedin') String? handleLinkedin,
    @JsonKey(name: 'handle_mirror') String? handleMirror,
    @JsonKey(name: 'handle_facebook') String? handleFacebook,
    @JsonKey(name: 'calendly_url') String? calendlyUrl,
  }) = _LensLemonadeProfile;

  factory LensLemonadeProfile.fromJson(Map<String, dynamic> json) =>
      _$LensLemonadeProfileFromJson(json);

  factory LensLemonadeProfile.fromLensAndLemonadeAccount({
    LensAccount? lensAccount,
    User? lemonadeAccount,
  }) {
    return LensLemonadeProfile(
      name: lensAccount?.name ?? lemonadeAccount?.name,
      description: lensAccount?.bio ?? lemonadeAccount?.description,
      imageAvatar: lensAccount != null
          ? lensAccount.picture ??
              AvatarUtils.randomUserImage(lensAccount.address ?? '')
          : lemonadeAccount?.imageAvatar ??
              AvatarUtils.randomUserImage(lemonadeAccount?.userId ?? ''),
      website: lensAccount?.website ?? lemonadeAccount?.website,
      jobTitle: lensAccount?.jobTitle ?? lemonadeAccount?.jobTitle,
      companyName: lensAccount?.companyName ?? lemonadeAccount?.companyName,
      pronoun: lensAccount?.pronoun ?? lemonadeAccount?.pronoun,
      handleTwitter:
          lensAccount?.handleTwitter ?? lemonadeAccount?.handleTwitter,
      handleFarcaster:
          lensAccount?.handleFarcaster ?? lemonadeAccount?.handleFarcaster,
      handleInstagram:
          lensAccount?.handleInstagram ?? lemonadeAccount?.handleInstagram,
      handleGithub: lensAccount?.handleGithub ?? lemonadeAccount?.handleGithub,
      handleLens: lensAccount?.handleLens ?? lemonadeAccount?.handleLens,
      handleLinkedin:
          lensAccount?.handleLinkedin ?? lemonadeAccount?.handleLinkedin,
      handleMirror: lensAccount?.handleMirror ?? lemonadeAccount?.handleMirror,
      handleFacebook:
          lensAccount?.handleFacebook ?? lemonadeAccount?.handleFacebook,
    );
  }

  Map<String, dynamic> generateLensAccountMetadata() {
    return {
      "\$schema": "https://json-schemas.lens.dev/account/1.0.0.json",
      "lens": {
        "id": const Uuid().v4(),
        "name": name,
        "bio": description,
        "picture": imageAvatar,
        "attributes": [
          ["website", website],
          ["job_title", jobTitle],
          ["company_name", companyName],
          ["pronoun", pronoun],
          ["handle_twitter", handleTwitter],
          ["handle_farcaster", handleFarcaster],
          ["handle_instagram", handleInstagram],
          ["handle_github", handleGithub],
          ["handle_lens", handleLens],
          ["handle_linkedin", handleLinkedin],
          ["handle_mirror", handleMirror],
          ["handle_facebook", handleFacebook],
          ["calendly_url", calendlyUrl],
        ]
            .map(
              (e) => {
                "key": e[0],
                "value": e[1] ?? '',
                "type": "String",
              },
            )
            .toList(),
      },
    };
  }
}
