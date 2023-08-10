import 'package:app/core/service/post/post_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/event/entities/event.dart';

part 'create_post_state.dart';

part 'create_post_bloc.freezed.dart';

class CreatePostBloc extends Cubit<CreatePostState> {
  CreatePostBloc(this.postService) : super(CreatePostState.initial());

  final PostService postService;

  void onPostDescriptionChange(String inputValue) {
    emit(state.copyWith(postDescription: inputValue));
  }

  void onEventSelect(Event? selectedEvent) {
    emit(state.copyWith(selectEvent: selectedEvent));
  }

  void onPostPrivacyChange(PostPrivacy privacy) {
    switch (privacy) {
      case PostPrivacy.public:
        emit(state.copyWith(postPrivacy: PostPrivacy.friend));
        break;
      case PostPrivacy.friend:
        emit(state.copyWith(postPrivacy: PostPrivacy.follower));
        break;
      case PostPrivacy.follower:
        emit(state.copyWith(postPrivacy: PostPrivacy.public));
        break;
    }
  }

  Future<void> onImagePick() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      emit(state.copyWith(uploadImage: pickImage));
    }
  }

  void onDismissImage() {
    emit(state.copyWith(uploadImage: null));
  }

  Future<void> createNewPost() async {}
}
