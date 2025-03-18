import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_space_detail_bloc.freezed.dart';

@freezed
class GetSpaceDetailEvent with _$GetSpaceDetailEvent {
  const factory GetSpaceDetailEvent.fetch({
    required String spaceId,
    @Default(false) bool refresh,
  }) = _Fetch;

  const factory GetSpaceDetailEvent.refresh({
    required String spaceId,
    @Default(false) bool refresh,
  }) = _Refresh;
}

@freezed
class GetSpaceDetailState with _$GetSpaceDetailState {
  const factory GetSpaceDetailState.initial() = _Initial;
  const factory GetSpaceDetailState.loading() = _Loading;
  const factory GetSpaceDetailState.success(Space space) = _Success;
  const factory GetSpaceDetailState.failure(Failure failure) = _Failure;
}

class GetSpaceDetailBloc
    extends Bloc<GetSpaceDetailEvent, GetSpaceDetailState> {
  final SpaceRepository _spaceRepository;

  GetSpaceDetailBloc(this._spaceRepository)
      : super(const GetSpaceDetailState.loading()) {
    on<_Fetch>(_onFetch);
    on<_Refresh>(_onRefresh);
  }

  Future<void> _onFetch(_Fetch event, Emitter emit) async {
    if (event.spaceId.isEmpty) {
      emit(GetSpaceDetailState.failure(Failure(message: "Space ID is empty")));
      return;
    }
    emit(const GetSpaceDetailState.loading());

    final result = await _spaceRepository.getSpaceDetail(
      spaceId: event.spaceId,
      refresh: event.refresh,
    );

    result.fold(
      (failure) => emit(GetSpaceDetailState.failure(failure)),
      (space) => emit(GetSpaceDetailState.success(space)),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter emit) async {
    if (event.spaceId.isEmpty) {
      emit(GetSpaceDetailState.failure(Failure(message: "Space ID is empty")));
      return;
    }

    final result = await _spaceRepository.getSpaceDetail(
      spaceId: event.spaceId,
      refresh: true,
    );

    result.fold(
      (failure) => emit(GetSpaceDetailState.failure(failure)),
      (space) => emit(GetSpaceDetailState.success(space)),
    );
  }
}
