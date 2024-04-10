import 'package:freezed_annotation/freezed_annotation.dart';

part 'applicant.freezed.dart';
part 'applicant.g.dart';

@freezed
class Applicant with _$Applicant {
  factory Applicant({
    @JsonKey(name: '_id') required String? id,
    String? email,
    @JsonKey(name: 'display_name') required String? displayName,
    @JsonKey(name: 'calendly_url') required String? calendlyUrl,
    @JsonKey(name: 'company_name') required String? companyName,
    @JsonKey(name: 'date_of_birth') required String? dateOfBirth,
    String? description,
    @JsonKey(name: 'education_title') required String? educationTitle,
    String? ethnicity,
    @JsonKey(name: 'handle_farcaster') required String? handleFarcaster,
    @JsonKey(name: 'handle_github') required String? handleGithub,
    @JsonKey(name: 'handle_instagram') required String? handleInstagram,
    @JsonKey(name: 'handle_lens') required String? handleLens,
    @JsonKey(name: 'handle_linkedin') required String? handleLinkedin,
    @JsonKey(name: 'handle_mirror') required String? handleMirror,
    @JsonKey(name: 'handle_twitter') required String? handleTwitter,
    @JsonKey(name: 'handle_avatar') required String? handleAvatar,
    String? industry,
    String? pronoun,
    String? tagline,
    String? username,
    @JsonKey(name: 'new_gender') required String? newGender,
    @JsonKey(name: 'job_title') required String? jobTitle,
  }) = _Applicant;

  factory Applicant.fromJson(Map<String, dynamic> json) =>
      _$ApplicantFromJson(json);
}
