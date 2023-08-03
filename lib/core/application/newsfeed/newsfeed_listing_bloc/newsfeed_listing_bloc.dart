import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/pagination/offset_pagination_service.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'newsfeed_listing_bloc.freezed.dart';

class NewsfeedListingBloc
    extends Bloc<NewsfeedListingEvent, NewsfeedListingState> {
  final PostService postService;
  late final OffsetPaginationService<Post, GetPostsInput>
      offsetPaginationService = OffsetPaginationService(
    getDataFuture: _getNewsfeed,
  );
  final GetPostsInput defaultInput;

  NewsfeedListingBloc(
    this.postService, {
    required this.defaultInput,
  }) : super(NewsfeedListingState.loading()) {
    on<NewsfeedListingEventFetch>(_onFetch);
  }

  Future<Either<Failure, List<Post>>> _getNewsfeed(int offset, bool endReached,
      {GetPostsInput? input}) async {
    return postService.getNewsfeed(input: input?.copyWith(offset: offset));
  }

  _onFetch(NewsfeedListingEventFetch event, Emitter emit) async {
    final result = await offsetPaginationService.fetch(defaultInput);
    result.fold(
      (l) => emit(NewsfeedListingState.failure()),
      (posts) => emit(
        NewsfeedListingState.fetched(
          posts: posts,
        ),
      ),
    );
  }
}

@freezed
class NewsfeedListingState with _$NewsfeedListingState {
  factory NewsfeedListingState.loading() = NewsfeedListingStateLoading;
  factory NewsfeedListingState.fetched({
    required List<Post> posts,
  }) = NewsfeedListingStateFetched;
  factory NewsfeedListingState.failure() = NewsfeedListingStateFailure;
}

@freezed
class NewsfeedListingEvent with _$NewsfeedListingEvent {
  factory NewsfeedListingEvent.fetch({GetPostsInput? input}) =
      NewsfeedListingEventFetch;
}
