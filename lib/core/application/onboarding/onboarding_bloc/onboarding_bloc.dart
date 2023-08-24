import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/post/post_service.dart';

part 'onboarding_state.dart';

part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Cubit<OnboardingState> {
  OnboardingBloc(this.postService) : super(OnboardingState.initial());

  final PostService postService;

  void onUsernameChange(String input) {
    emit(state.copyWith(username: input));
  }

  void onGenderSelect(OnboardingGender gender){
    emit(state.copyWith(gender: gender));
  }

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
}
