import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/post_input.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_listing_bloc.freezed.dart';

class PostsListingBloc extends Bloc<PostsListingEvent, PostsListingState> {
  final PostService postService;
  PostsListingBloc(this.postService) : super(PostsListingState.loading()) {
    on<PostsListingEventFetch>(_onFetch);
  }

  _onFetch(PostsListingEventFetch event, Emitter emit) async {
    emit(PostsListingState.loading());
    final result = await postService.getPosts(input: event.input);
    result.fold(
      (l) => emit(PostsListingState.failure()),
      (posts) => emit(
        PostsListingState.fetched(
          posts: posts,
        ),
      ),
    );
  }
}

@freezed
class PostsListingState with _$PostsListingState {
  factory PostsListingState.loading() = PostsListingStateLoading;
  factory PostsListingState.fetched({
    required List<Post> posts,
  }) = PostsListingStateFetched;
  factory PostsListingState.failure() = PostsListingStateFailure;
}

@freezed
class PostsListingEvent with _$PostsListingEvent {
  factory PostsListingEvent.fetch({
    GetPostsInput? input
  }) = PostsListingEventFetch;
}
