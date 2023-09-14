import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/service/post/post_service.dart';
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

  String? mImageId;

  Future<void> selectProfileImage() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      emit(
        state.copyWith(
          profilePhoto: pickImage,
        ),
      );
    }
  }

  void onShortBioChange(String input) {
    emit(state.copyWith(shortBio: input));
  }

  void onDisplayNameChange(String input) {
    emit(state.copyWith(displayName: input));
  }

  void onTaglineChange(String input) {
    emit(state.copyWith(tagline: input));
  }

  void onJobTitleChange(String input) {
    emit(state.copyWith(jobTitle: input));
  }

  void onOrganizationChange(String input) {
    emit(state.copyWith(companyName: input));
  }

  void onEducationChange(String input) {
    emit(state.copyWith(education: input));
  }

  void onGenderSelect(String? gender) {
    emit(state.copyWith(gender: gender));
  }

  void onIndustrySelect(String? industry) {
    emit(state.copyWith(industry: industry));
  }

  void onEthnicitySelect(String? ethnicity) {
    emit(state.copyWith(ethnicity: ethnicity));
  }

  void onBirthdaySelect() {}

  Future<void> uploadImage() async {
    final response = await postService.uploadImage(
      state.profilePhoto!,
      directory: 'photos',
    );
    response.fold(
      (l) => emit(state.copyWith(status: EditProfileStatus.error)),
      (imageId) => mImageId = imageId,
    );
  }

  Future<void> editProfile() async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    if (state.profilePhoto != null) {
      await uploadImage();
    }
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
          emit(state.copyWith(status: EditProfileStatus.success));
        } else {
          emit(state.copyWith(status: EditProfileStatus.error));
        }
      },
    );
  }
}
