part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default(EditProfileStatus.initial) EditProfileStatus status,
    String? username,
    LemonPronoun? pronoun,
    String? companyName,
    DateTime? dob,
    String? displayName,
    String? education,
    String? industry,
    String? gender,
    String? ethnicity,
    String? jobTitle,
    String? tagline,
    String? shortBio,
    XFile? profilePhoto,
    List<dynamic>? interestList,
    String? handleTwitter,
    String? handleLinkedin,
    String? handleInstagram,
    String? handleFarcaster,
    String? handleGithub,
    String? handleLens,
    String? handleMirror,
    String? calendlyUrl,
    String? website,
    Map<NotificationSettingType, bool>? notificationMap,
  }) = _EditProfileState;

  factory EditProfileState.initial() => const EditProfileState();
}

enum EditProfileStatus {
  initial,
  editing,
  loading,
  success,
  error,
}
