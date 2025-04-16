import 'package:app/core/domain/space/entities/get_space_event_requests_response.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/space/query/get_space_event_requests.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_space_event_requests_bloc.freezed.dart';

@freezed
class GetSpaceEventRequestsEvent with _$GetSpaceEventRequestsEvent {
  const factory GetSpaceEventRequestsEvent.fetch({
    required Variables$Query$GetSpaceEventRequests input,
    @Default(false) bool refresh,
  }) = _GetSpaceEventRequestsEventFetch;

  const factory GetSpaceEventRequestsEvent.reset() =
      _GetSpaceEventRequestsEventReset;
}

@freezed
class GetSpaceEventRequestsState with _$GetSpaceEventRequestsState {
  const factory GetSpaceEventRequestsState.initial() =
      _GetSpaceEventRequestsStateInitial;
  const factory GetSpaceEventRequestsState.loading() =
      _GetSpaceEventRequestsStateLoading;
  const factory GetSpaceEventRequestsState.success(
    GetSpaceEventRequestsResponse response,
  ) = _GetSpaceEventRequestsStateSuccess;
  const factory GetSpaceEventRequestsState.failure(Failure failure) =
      _GetSpaceEventRequestsStateFailure;
}

class GetSpaceEventRequestsBloc
    extends Bloc<GetSpaceEventRequestsEvent, GetSpaceEventRequestsState> {
  final SpaceRepository _spaceRepository;

  GetSpaceEventRequestsBloc({
    required SpaceRepository spaceRepository,
  })  : _spaceRepository = spaceRepository,
        super(const GetSpaceEventRequestsState.initial()) {
    on<_GetSpaceEventRequestsEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    _GetSpaceEventRequestsEventFetch event,
    Emitter<GetSpaceEventRequestsState> emit,
  ) async {
    if (!event.refresh) {
      emit(const GetSpaceEventRequestsState.loading());
    }

    final result = await _spaceRepository.getSpaceEventRequests(
      input: event.input,
      refresh: event.refresh,
    );

    result.fold(
      (failure) => emit(GetSpaceEventRequestsState.failure(failure)),
      (response) => emit(GetSpaceEventRequestsState.success(response)),
    );
  }
}
