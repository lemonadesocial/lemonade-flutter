import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/debouncer.dart';

part 'onboarding_state.dart';

part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Cubit<OnboardingState> {
  OnboardingBloc(
    this.userRepository,
    this.postService,
  ) : super(OnboardingState.initial());

  final UserRepository userRepository;
  final PostService postService;
  final debouncer = Debouncer(milliseconds: 500);

  void onUsernameChange(String input) {
    // Reset valid input
    emit(
      state.copyWith(
        status: OnboardingStatus.initial,
        username: input,
        usernameExisted: null,
      ),
    );
    // Check valid username
    debouncer.run(() async {
      if (input.isNotEmpty) {
        final response =
            await userRepository.checkValidUsername(username: input);
        response.fold(
          (l) => emit(
            state.copyWith(
              status: OnboardingStatus.error,
              usernameExisted: true,
            ),
          ),
          (userExisted) {
            if (userExisted) {
              emit(state.copyWith(usernameExisted: true));
            } else {
              emit(
                state.copyWith(
                  status: OnboardingStatus.error,
                  usernameExisted: false,
                ),
              );
            }
          },
        );
      }
    });
  }

  void onGenderSelect(OnboardingGender gender) {
    emit(state.copyWith(status: OnboardingStatus.initial, gender: gender));
  }

  void onDisplayNameChange(String input) {
    emit(state.copyWith(
        status: OnboardingStatus.initial, aboutDisplayName: input));
  }

  void onShortBioChange(String input) {
    emit(
        state.copyWith(status: OnboardingStatus.initial, aboutShortBio: input));
  }

  Future<void> selectProfileImage() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      emit(
        state.copyWith(
          status: OnboardingStatus.initial,
          profilePhoto: pickImage,
        ),
      );
    }
  }

  Future<void> uploadImage() async {
    final response = await postService.uploadImage(
      state.profilePhoto!,
      directory: 'photos',
    );
    response.fold(
      (l) => emit(state.copyWith(status: OnboardingStatus.error)),
      (imageId) {
        updateProfile(imageId: imageId);
      },
    );
  }

  Future<void> updateProfile({String? imageId}) async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final response = await userRepository.updateUserProfile(
      UpdateUserProfileInput(
        username: state.username!,
        gender: state.gender,
        displayName: state.aboutDisplayName,
        shortBio: state.aboutShortBio,
        uploadPhoto: imageId != null ? [imageId] : null,
      ),
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          status: OnboardingStatus.error,
        ),
      ),
      (success) {
        if (success) {
          emit(state.copyWith(status: OnboardingStatus.success));
        } else {
          emit(state.copyWith(status: OnboardingStatus.error));
        }
      },
    );
  }
}
