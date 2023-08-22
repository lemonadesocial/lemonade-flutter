import 'package:app/core/domain/newsfeed/input/get_newsfeed_input.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/newsfeed/newsfeed_service.dart';
import 'package:app/core/service/pagination/offset_pagination_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'newsfeed_listing_bloc.freezed.dart';

class NewsfeedListingBloc extends Bloc<NewsfeedListingEvent, NewsfeedListingState> {
  NewsfeedListingBloc(
    this.newsfeedService, {
    required this.defaultInput,
  }) : super(NewsfeedListingState.initial()) {
    on<NewsfeedListingEventFetch>(_onFetch);
  }

  final NewsfeedService newsfeedService;
  late final OffsetPaginationService<Post, GetNewsfeedInput> offsetPaginationService =
      OffsetPaginationService(
    getDataFuture: _getNewsfeed,
  );
  final GetNewsfeedInput defaultInput;

  Future<Either<Failure, List<Post>>> _getNewsfeed(
    int? offset,
    bool endReached, {
    GetNewsfeedInput? input,
  }) async {
    final result = await newsfeedService.getNewsfeed(input: input?.copyWith(offset: offset));
    return result.fold(
      Left.new,
      (newsfeed) {
        offsetPaginationService.updateOffset(newsfeed.offset);
        return Right(newsfeed.posts ?? []);
      },
    );
  }

  Future<void> _onFetch(NewsfeedListingEventFetch event, Emitter emit) async {
    emit(NewsfeedListingState.loading());
    final result = await offsetPaginationService.fetch(defaultInput);
    result.fold(
      (l) => emit(NewsfeedListingState.failure()),
      (posts) => emit(
        NewsfeedListingState.fetched(posts: posts),
      ),
    );
  }
}

@freezed
class NewsfeedListingState with _$NewsfeedListingState {
  factory  NewsfeedListingState.initial() = NewsfeedListingStateInitial;
  factory NewsfeedListingState.loading() = NewsfeedListingStateLoading;
  factory NewsfeedListingState.fetched({
    required List<Post> posts,
  }) = NewsfeedListingStateFetched;
  factory NewsfeedListingState.failure() = NewsfeedListingStateFailure;
}

@freezed
class NewsfeedListingEvent with _$NewsfeedListingEvent {
  factory NewsfeedListingEvent.fetch({GetNewsfeedInput? input}) =
      NewsfeedListingEventFetch;
}
