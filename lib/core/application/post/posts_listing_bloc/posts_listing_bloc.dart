import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_listing_bloc.freezed.dart';

class PostsListingBloc extends Bloc<PostsListingEvent, PostsListingState> {
  final PostService postService;
  late final PaginationService<Post, GetPostsInput> paginationService = PaginationService(
    getDataFuture: _getPosts,
  );
  final GetPostsInput defaultInput;

  PostsListingBloc(this.postService, {
    required this.defaultInput,
  }) : super(PostsListingState.loading()) {
    on<PostsListingEventFetch>(_onFetch);
  }

  Future<Either<Failure, List<Post>>> _getPosts(int skip, bool endReached, { GetPostsInput? input }) async {
    return postService.getPosts(input: input?.copyWith(skip: skip));
  }

  _onFetch(PostsListingEventFetch event, Emitter emit) async {
    final result = await paginationService.fetch(defaultInput);
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
