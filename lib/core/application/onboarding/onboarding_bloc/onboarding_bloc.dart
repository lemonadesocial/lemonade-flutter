import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app/core/utils/debouncer.dart';

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
    final mInput = input.trim();
    // Reset valid input
    emit(
      state.copyWith(
        status: mInput.isEmpty
            ? OnboardingStatus.initial
            : OnboardingStatus.loading,
        username: input,
        usernameExisted: null,
      ),
    );
    // Check valid username
    debouncer.run(() async {
      if (input.isNotEmpty) {
        final response =
            await userRepository.checkValidUsername(username: mInput);
        response.fold(
          (l) => emit(
            state.copyWith(
              status: OnboardingStatus.error,
              usernameExisted: true,
            ),
          ),
          (userExisted) {
            if (userExisted) {
              emit(
                state.copyWith(
                  status: OnboardingStatus.error,
                  usernameExisted: true,
                ),
              );
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

  void onGenderSelect(LemonPronoun gender) {
    emit(state.copyWith(status: OnboardingStatus.initial, gender: gender));
  }

  void onDisplayNameChange(String input) {
    emit(
      state.copyWith(
        status: OnboardingStatus.initial,
        aboutDisplayName: input,
      ),
    );
  }

  void onShortBioChange(String input) {
    emit(
      state.copyWith(status: OnboardingStatus.initial, aboutShortBio: input),
    );
  }

  Future<void> selectProfileImage() async {
    final pickImage = await getImageFromGallery(cropRequired: true);
    if (pickImage != null) {
      emit(
        state.copyWith(
          status: OnboardingStatus.initial,
          profilePhoto: pickImage,
        ),
      );
    }
  }

  void removeImage() {
    emit(
      state.copyWith(
        status: OnboardingStatus.initial,
        profilePhoto: null,
      ),
    );
  }

  Future<void> uploadImage() async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    try {
      final client = getIt<AppGQL>().client;
      final fileUploadService = FileUploadService(client);
      String? imageId = await fileUploadService.uploadSingleFile(
        state.profilePhoto,
        FileDirectory.user,
      );
      if (imageId != null) {
        updateProfile(imageId: imageId);
      }
    } catch (e) {
      emit(state.copyWith(status: OnboardingStatus.error));
    }
  }

  Future<void> updateProfile({String? imageId}) async {
    if (state.username == null || state.username!.isEmpty) {
      emit(state.copyWith(status: OnboardingStatus.error));
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.loading));
    final response = await userRepository.updateUserProfile(
      UpdateUserProfileInput(
        username: state.username!,
        pronoun: state.gender,
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

  Future<void> acceptTerm(UpdateUserProfileInput input) async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final response = await userRepository.updateUserProfile(
      input,
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
