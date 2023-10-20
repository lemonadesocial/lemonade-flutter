import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/create_post_comment_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_comment_bloc.freezed.dart';

class CreatePostCommentBloc
    extends Bloc<CreatePostCommentEvent, CreatePostCommentState> {
  final postRepository = getIt<PostRepository>();

  CreatePostCommentBloc() : super(CreatePostCommentState.loading()) {
    on<CreatePostCommentEventCreate>(_onCreateComment);
  }

  Future<void> _onCreateComment(
    CreatePostCommentEventCreate event,
    Emitter emit,
  ) async {
    emit(CreatePostCommentState.loading());

    final result = await postRepository.createPostComment(input: event.input);

    result.fold(
      (failure) => emit(
        CreatePostCommentState.failure(),
      ),
      (newComment) => emit(
        CreatePostCommentState.success(comment: newComment),
      ),
    );
  }
}

@freezed
class CreatePostCommentEvent with _$CreatePostCommentEvent {
  factory CreatePostCommentEvent.create({
    required CreatePostCommentInput input,
  }) = CreatePostCommentEventCreate;
}

@freezed
class CreatePostCommentState with _$CreatePostCommentState {
  factory CreatePostCommentState.loading() = CreatePostCommentStateLoading;
  factory CreatePostCommentState.failure() = CreatePostCommentStateFailure;
  factory CreatePostCommentState.success({
    required PostComment comment,
  }) = CreatePostCommentStateSuccess;
}
