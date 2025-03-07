import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

part 'list_spaces_bloc.freezed.dart';

@freezed
class ListSpacesEvent with _$ListSpacesEvent {
  const factory ListSpacesEvent.fetch({
    bool? withMySpaces,
    bool? withPublicSpaces,
    List<Enum$SpaceRole>? roles,
  }) = _FetchListSpacesEvent;
}

@freezed
class ListSpacesState with _$ListSpacesState {
  const factory ListSpacesState.initial() = _InitialListSpacesState;

  const factory ListSpacesState.loading() = _LoadingListSpacesState;

  const factory ListSpacesState.success({
    required List<Space> spaces,
  }) = _RefreshingListSpacesState;

  const factory ListSpacesState.failure({
    Failure? failure,
  }) = _FailureListSpacesState;
}

// BLoC class
class ListSpacesBloc extends Bloc<ListSpacesEvent, ListSpacesState> {
  final SpaceRepository _spaceRepository;
  final bool? withMySpaces;
  final bool? withPublicSpaces;
  final List<Enum$SpaceRole>? roles;

  ListSpacesBloc({
    required SpaceRepository spaceRepository,
    this.withMySpaces,
    this.withPublicSpaces,
    this.roles,
  })  : _spaceRepository = spaceRepository,
        super(const ListSpacesState.initial()) {
    on<_FetchListSpacesEvent>(_onFetch);
  }

  Future<void> _onFetch(
    _FetchListSpacesEvent event,
    Emitter<ListSpacesState> emit,
  ) async {
    emit(const ListSpacesState.loading());

    final result = await _spaceRepository.listSpaces(
      withMySpaces: event.withMySpaces ?? withMySpaces,
      withPublicSpaces: event.withPublicSpaces ?? withPublicSpaces,
      roles: event.roles ?? roles,
    );
    result.fold(
      (failure) => emit(ListSpacesState.failure(failure: failure)),
      (spaces) => emit(ListSpacesState.success(spaces: spaces)),
    );
  }
}
