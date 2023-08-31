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

  PostRefType? postRefType;
  String? postRefId;

  void onPostDescriptionChange(String inputValue) {
    emit(state.copyWith(postDescription: inputValue));
  }

  void onEventSelect(Event? selectedEvent) {
    emit(
      state.copyWith(
        selectEvent: selectedEvent,
        uploadImage: null,
      ),
    );
  }

  void onPostPrivacyChange(PostPrivacy privacy) {
    switch (privacy) {
      case PostPrivacy.public:
        emit(state.copyWith(postPrivacy: PostPrivacy.friends));
        break;
      case PostPrivacy.friends:
        emit(state.copyWith(postPrivacy: PostPrivacy.followers));
        break;
      case PostPrivacy.followers:
        emit(state.copyWith(postPrivacy: PostPrivacy.public));
        break;
    }
  }

  Future<void> onImagePick() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      emit(
        state.copyWith(
          uploadImage: pickImage,
          selectEvent: null,
        ),
      );
    }
  }

  void onDismissImage() {
    emit(state.copyWith(uploadImage: null));
  }

  Future<void> createNewPost() async {
    emit(state.copyWith(status: CreatePostStatus.loading));
    if (state.uploadImage != null) {
      await uploadImage(state.uploadImage!);
    }
    if (state.selectEvent != null) {
      postRefType = PostRefType.event;
      postRefId = state.selectEvent!.id;
    }

    final response = await postService.createPost(
      postDescription: state.postDescription!,
      postPrivacy: state.postPrivacy,
      postRefType: postRefType,
      postRefId: postRefId,
    );
    response.fold(
      (l) => emit(state.copyWith(status: CreatePostStatus.error)),
      (isUpdateSuccess) =>
          emit(state.copyWith(status: CreatePostStatus.postCreated)),
    );
  }

  Future<void> uploadImage(XFile file) async {
    final response = await postService.uploadImage(file, directory: 'post');
    response.fold(
      (l) => emit(state.copyWith(status: CreatePostStatus.error)),
      (imageId) {
        postRefType = PostRefType.file;
        postRefId = imageId;
      },
    );
  }
}
