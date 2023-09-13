import 'package:app/core/domain/common/common_enums.dart';
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

  Future<void> selectProfileImage() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      emit(
        state.copyWith(
          status: EditProfileStatus.initial,
          profilePhoto: pickImage,
        ),
      );
    }
  }
}
