import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_post_comments_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_post_comments_bloc.freezed.dart';

class GetPostCommentsBloc
    extends Bloc<GetPostCommentsEvent, GetPostCommentsState> {
  late final PaginationService<PostComment, GetPostCommentsInput>
      paginationService = PaginationService(getDataFuture: getPostComments);
  final postRepository = getIt<PostRepository>();

  GetPostCommentsBloc() : super(GetPostCommentsState.loading()) {
    on<GetPostCommentsEventFetch>(_onFetch);
    on<GetPostCommentsEventRefresh>(_onRefresh);
  }

  Future<Either<Failure, List<PostComment>>> getPostComments(
    int skip,
    bool endReached, {
    required GetPostCommentsInput input,
  }) async {
    return await postRepository.getPostComments(
      input: input.copyWith(skip: skip),
    );
  }

  Future<void> _onFetch(GetPostCommentsEventFetch event, Emitter emit) async {
    final result = await paginationService.fetch(event.input);

    result.fold(
      (l) => emit(
        GetPostCommentsState.failure(),
      ),
      (comments) => emit(
        GetPostCommentsState.success(comments: comments),
      ),
    );
  }

  Future<void> _onRefresh(
    GetPostCommentsEventRefresh event,
    Emitter emit,
  ) async {
    final result = await paginationService.refresh(event.input);

    result.fold(
      (l) => emit(
        GetPostCommentsState.failure(),
      ),
      (comments) {
        emit(
          GetPostCommentsState.success(comments: comments),
        );
      },
    );
  }
}

@freezed
class GetPostCommentsEvent with _$GetPostCommentsEvent {
  factory GetPostCommentsEvent.fetch({
    required GetPostCommentsInput input,
  }) = GetPostCommentsEventFetch;

  factory GetPostCommentsEvent.refresh({
    required GetPostCommentsInput input,
  }) = GetPostCommentsEventRefresh;
}

@freezed
class GetPostCommentsState with _$GetPostCommentsState {
  factory GetPostCommentsState.loading() = GetPostCommentsStateLoading;
  factory GetPostCommentsState.failure() = GetPostCommentsStateFailure;
  factory GetPostCommentsState.success({
    required List<PostComment> comments,
  }) = GetPostCommentsStateSuccess;
}
