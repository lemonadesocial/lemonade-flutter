part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default(EditProfileStatus.initial) EditProfileStatus status,
    bool? usernameExisted,
    String? username,
    XFile? profilePhoto,
    LemonGender? gender,
    String? aboutDisplayName,
    String? aboutShortBio,
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
