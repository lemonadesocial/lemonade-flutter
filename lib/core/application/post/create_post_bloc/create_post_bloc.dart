import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';

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
    emit(state.copyWith(postPrivacy: privacy));
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
      (newPost) => emit(
        state.copyWith(
          status: CreatePostStatus.postCreated,
          newPost: newPost,
        ),
      ),
    );
  }

  Future<void> uploadImage(XFile file) async {
    try {
      final client = getIt<AppGQL>().client;
      final fileUploadService = FileUploadService(client);
      String? imageId = await fileUploadService.uploadSingleFile(
        file,
        FileDirectory.post,
      );
      if (imageId != null) {
        postRefType = PostRefType.file;
        postRefId = imageId;
      }
    } catch (e) {
      emit(state.copyWith(status: CreatePostStatus.error));
    }
  }
}
