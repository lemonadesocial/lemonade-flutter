part of 'create_post_bloc.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    @Default(CreatePostStatus.initial) CreatePostStatus status,
    @Default(PostPrivacy.public) PostPrivacy postPrivacy,
    String? postDescription,
    Event? selectEvent,
    XFile? uploadImage,
    String? error,
  }) = _CreatePostState;

  factory CreatePostState.initial() => const CreatePostState();
}

enum CreatePostStatus {
  initial,
  loading,
  postCreated,
  error,
}

enum PostPrivacy {
  public,
  friends,
  followers,
}

enum PostRefType {
  file,
  event,
}
