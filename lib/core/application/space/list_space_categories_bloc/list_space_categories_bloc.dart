import 'package:app/core/domain/space/entities/space_category.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_space_categories_bloc.freezed.dart';

@freezed
class ListSpaceCategoriesEvent with _$ListSpaceCategoriesEvent {
  const factory ListSpaceCategoriesEvent.fetch() =
      _FetchListSpaceCategoriesEvent;
}

@freezed
class ListSpaceCategoriesState with _$ListSpaceCategoriesState {
  const factory ListSpaceCategoriesState.initial() =
      _InitialListSpaceCategoriesState;
  const factory ListSpaceCategoriesState.loading() =
      _LoadingListSpaceCategoriesState;
  const factory ListSpaceCategoriesState.success({
    required List<SpaceCategory> categories,
  }) = _SuccessListSpaceCategoriesState;
  const factory ListSpaceCategoriesState.failure({
    Failure? failure,
  }) = _FailureListSpaceCategoriesState;
}

class ListSpaceCategoriesBloc
    extends Bloc<ListSpaceCategoriesEvent, ListSpaceCategoriesState> {
  final SpaceRepository _spaceRepository;

  ListSpaceCategoriesBloc({
    required SpaceRepository spaceRepository,
  })  : _spaceRepository = spaceRepository,
        super(const ListSpaceCategoriesState.initial()) {
    on<_FetchListSpaceCategoriesEvent>(_onFetch);
  }

  Future<void> _onFetch(
    _FetchListSpaceCategoriesEvent event,
    Emitter<ListSpaceCategoriesState> emit,
  ) async {
    emit(const ListSpaceCategoriesState.loading());

    final result = await _spaceRepository.listSpaceCategories();
    result.fold(
      (failure) => emit(ListSpaceCategoriesState.failure(failure: failure)),
      (categories) =>
          emit(ListSpaceCategoriesState.success(categories: categories)),
    );
  }
}
