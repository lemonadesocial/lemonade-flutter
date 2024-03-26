part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  factory EditProfileEvent.selectProfileImage() =
      EditProfileEventSelectProfileImage;
  factory EditProfileEvent.shortBioChange({required String input}) =
      EditProfileEventShortBioChange;
  factory EditProfileEvent.displayNameChange({required String input}) =
      EditProfileEventDisplayNameChange;
  factory EditProfileEvent.taglineChange({required String input}) =
      EditProfileEventTaglineChange;
  factory EditProfileEvent.jobTitleChange({required String input}) =
      EditProfileEventJobTitleChange;
  factory EditProfileEvent.organizationChange({required String input}) =
      EditProfileEventOrganizationChange;
  factory EditProfileEvent.educationChange({required String input}) =
      EditProfileEventEducationChange;
  factory EditProfileEvent.genderSelect({required String? gender}) =
      EditProfileEventGenderSelect;
  factory EditProfileEvent.industrySelect({required String? industry}) =
      EditProfileEventIndustrySelect;
  factory EditProfileEvent.ethnicitySelect({required String? ethnicity}) =
      EditProfileEventEthnicitySelect;
  factory EditProfileEvent.usernameChange({required String input}) =
      EditProfileEventUsernameChange;
  factory EditProfileEvent.birthdayChange({required DateTime input}) =
      EditProfileEventBirthdayChange;
  factory EditProfileEvent.mapNotificationType({
    required List<String> notificationFilterString,
  }) = EditProfileEventMapNotificationType;
  factory EditProfileEvent.notificationCheck({
    required NotificationSettingType type,
  }) = EditProfileEventNotificationCheck;
  factory EditProfileEvent.submitEditProfile() =
      EditProfileEventSubmitEditProfile;
  factory EditProfileEvent.clearState() = EditProfileEventClearState;
}
