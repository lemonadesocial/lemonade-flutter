import 'package:app/core/domain/newsfeed/input/get_newsfeed_input.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/newsfeed/newsfeed_service.dart';
import 'package:app/core/service/pagination/offset_pagination_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'newsfeed_listing_bloc.freezed.dart';

class NewsfeedListingBloc
    extends Bloc<NewsfeedListingEvent, NewsfeedListingState> {
  NewsfeedListingBloc(this.newsfeedService)
      : super(NewsfeedListingState.initial()) {
    on<NewsfeedListingEventFetch>(_onFetch);
    on<NewsfeedListingEventNewPost>(_onNewPostAdded);
    on<NewsfeedListingEventRefresh>(_onRefresh);
    on<NewsfeedListingEventScrollTop>(_onScroll);
  }

  final NewsfeedService newsfeedService;
  late final OffsetPaginationService<Post, GetNewsfeedInput>
      offsetPaginationService = OffsetPaginationService(
    getDataFuture: _getNewsfeed,
  );
  final defaultInput = const GetNewsfeedInput();
  final scrollController = ScrollController();

  Future<Either<Failure, List<Post>>> _getNewsfeed(
    int? offset,
    bool endReached, {
    GetNewsfeedInput? input,
  }) async {
    final result = await newsfeedService.getNewsfeed(
        input: input?.copyWith(offset: offset));
    return result.fold(
      Left.new,
      (newsfeed) {
        offsetPaginationService.updateOffset(newsfeed.offset);
        return Right(newsfeed.posts ?? []);
      },
    );
  }

  Future<void> _onFetch(NewsfeedListingEventFetch event, Emitter emit) async {
    emit(state.copyWith(status: NewsfeedStatus.loading));
    final result = await offsetPaginationService.fetch(defaultInput);
    result.fold(
      (l) => emit(state.copyWith(status: NewsfeedStatus.failure)),
      (posts) => emit(
        state.copyWith(
          status: NewsfeedStatus.fetched,
          posts: posts,
        ),
      ),
    );
  }

  Future<void> _onRefresh(
    NewsfeedListingEventRefresh event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: NewsfeedStatus.loading));
    final result = await offsetPaginationService.refresh(defaultInput);
    result.fold(
      (l) => emit(state.copyWith(status: NewsfeedStatus.failure)),
      (posts) => emit(
        state.copyWith(
          status: NewsfeedStatus.fetched,
          posts: posts,
        ),
      ),
    );
  }

  void _onNewPostAdded(NewsfeedListingEventNewPost event, Emitter emit) {
    final newPostList = List.of(state.posts);
    newPostList.insert(0, event.post);
    emit(
      state.copyWith(
          status: NewsfeedStatus.fetched,
          posts: newPostList,
          scrollToTopEvent: true),
    );
  }

  void _onScroll(NewsfeedListingEventScrollTop event, Emitter emit) {
    emit(state.copyWith(scrollToTopEvent: event.scrollToTopEvent));
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}

@freezed
class NewsfeedListingState with _$NewsfeedListingState {
  const factory NewsfeedListingState({
    @Default(NewsfeedStatus.initial) NewsfeedStatus status,
    @Default([]) List<Post> posts,
    @Default(false) bool scrollToTopEvent,
  }) = NewsfeedListingStatus;

  factory NewsfeedListingState.initial() => const NewsfeedListingState();
}

@freezed
class NewsfeedListingEvent with _$NewsfeedListingEvent {
  factory NewsfeedListingEvent.fetch({GetNewsfeedInput? input}) =
      NewsfeedListingEventFetch;

  factory NewsfeedListingEvent.refresh({GetNewsfeedInput? input}) =
      NewsfeedListingEventRefresh;

  factory NewsfeedListingEvent.newPostAdded({required Post post}) =
      NewsfeedListingEventNewPost;

  factory NewsfeedListingEvent.scrollToTop({required bool scrollToTopEvent}) =
      NewsfeedListingEventScrollTop;
}

enum NewsfeedStatus {
  initial,
  loading,
  fetched,
  failure,
}
