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
  }) = _EditProfileState;

  factory EditProfileState.initial() => const EditProfileState();
}

enum EditProfileStatus {
  initial,
  loading,
  success,
  error,
}
