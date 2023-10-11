import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/setting/enums/notification_type.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_state.dart';

part 'edit_profile_bloc.freezed.dart';

class EditProfileBloc extends Cubit<EditProfileState> {
  EditProfileBloc(
    this.userRepository,
    this.postService,
  ) : super(EditProfileState.initial());

  final UserRepository userRepository;
  final PostService postService;
  final birthDayCtrl = TextEditingController();
  final notificationMap = <NotificationSettingType, bool>{};

  String? mImageId;

  Future<void> selectProfileImage() async {
    final pickImage = await getImageFromGallery(cropRequired: true);
    if (pickImage != null) {
      emit(
        state.copyWith(
          status: EditProfileStatus.editing,
          profilePhoto: pickImage,
        ),
      );
    }
  }

  void onShortBioChange(String input) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        shortBio: input,
      ),
    );
  }

  void onDisplayNameChange(String input) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        displayName: input,
      ),
    );
  }

  void onTaglineChange(String input) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        tagline: input,
      ),
    );
  }

  void onJobTitleChange(String input) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        jobTitle: input,
      ),
    );
  }

  void onOrganizationChange(String input) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        companyName: input,
      ),
    );
  }

  void onEducationChange(String input) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        education: input,
      ),
    );
  }

  void onGenderSelect(String? gender) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        gender: gender,
      ),
    );
  }

  void onIndustrySelect(String? industry) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        industry: industry,
      ),
    );
  }

  void onEthnicitySelect(String? ethnicity) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        ethnicity: ethnicity,
      ),
    );
  }

  void onUsernameChange(String input) {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        username: input,
      ),
    );
  }

  void onBirthdayChange(String input) {
    birthDayCtrl.text = input;
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        dob: input,
      ),
    );
  }

  void mapNotificationType(List<String> notificationFilterString) {
    for (final type in NotificationSettingType.values) {
      notificationMap.putIfAbsent(
        type,
        () => notificationFilterString.any(
          (filter) => filter.startsWith('${type.name}_'),
        ),
      );
    }
    emit(state.copyWith(notificationMap: notificationMap));
  }

  void onNotificationCheck(NotificationSettingType type, bool isChecked) {
    final newMap =
        Map<NotificationSettingType, bool>.from(state.notificationMap!);
    newMap[type] = !state.notificationMap![type]!;

    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        notificationMap: newMap,
      ),
    );
  }

  void clearState() {
    emit(state.copyWith(status: EditProfileStatus.initial));
  }

  Future<void> uploadImage() async {
    final response = await postService.uploadImage(
      state.profilePhoto!,
      directory: 'photos',
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          status: EditProfileStatus.error,
        ),
      ),
      (imageId) => mImageId = imageId,
    );
  }

  Future<void> editProfile() async {
    emit(
      state.copyWith(
        status: EditProfileStatus.loading,
      ),
    );
    if (state.profilePhoto != null) {
      await uploadImage();
    }
    final notificationFilterInput = <NotificationFilterInput>[];
    state.notificationMap?.forEach((type, value) {
      if (value) {
        notificationFilterInput.addAll(
          type.notificationDetail
              .map((e) => NotificationFilterInput(type: e))
              .toList(),
        );
      }
    });
    final response = await userRepository.updateUserProfile(
      UpdateUserProfileInput(
        username: state.username,
        pronoun: state.pronoun,
        displayName: state.displayName,
        tagline: state.tagline,
        shortBio: state.shortBio,
        jobTitle: state.jobTitle,
        educationTitle: state.education,
        industry: state.industry,
        newGender: state.gender,
        ethnicity: state.ethnicity,
        companyName: state.companyName,
        uploadPhoto: mImageId != null ? [mImageId!] : null,
        notificationFilterInput:
            notificationFilterInput.isEmpty ? null : notificationFilterInput,
      ),
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          status: EditProfileStatus.error,
        ),
      ),
      (success) {
        if (success) {
          emit(
            state.copyWith(
              status: EditProfileStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: EditProfileStatus.error,
            ),
          );
        }
      },
    );
  }
}
