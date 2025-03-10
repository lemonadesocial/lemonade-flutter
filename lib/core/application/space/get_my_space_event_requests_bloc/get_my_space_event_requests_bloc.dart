import 'package:app/core/domain/space/entities/get_space_event_requests_response.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/query/get_my_space_requests.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_my_space_event_requests_bloc.freezed.dart';

@freezed
class GetMySpaceEventRequestsEvent with _$GetMySpaceEventRequestsEvent {
  const factory GetMySpaceEventRequestsEvent.fetch({
    required String spaceId,
    Enum$EventJoinRequestState? state,
    @Default(10) int limit,
    @Default(0) int skip,
  }) = _GetMySpaceEventRequestsEventFetch;

  const factory GetMySpaceEventRequestsEvent.reset() =
      _GetMySpaceEventRequestsEventReset;
}

@freezed
class GetMySpaceEventRequestsState with _$GetMySpaceEventRequestsState {
  const factory GetMySpaceEventRequestsState.initial() =
      _GetMySpaceEventRequestsStateInitial;
  const factory GetMySpaceEventRequestsState.loading() =
      _GetMySpaceEventRequestsStateLoading;
  const factory GetMySpaceEventRequestsState.success(
    GetSpaceEventRequestsResponse response,
  ) = _GetMySpaceEventRequestsStateSuccess;
  const factory GetMySpaceEventRequestsState.failure(Failure failure) =
      _GetMySpaceEventRequestsStateFailure;
}

class GetMySpaceEventRequestsBloc
    extends Bloc<GetMySpaceEventRequestsEvent, GetMySpaceEventRequestsState> {
  final SpaceRepository _spaceRepository;

  GetMySpaceEventRequestsBloc({
    required SpaceRepository spaceRepository,
  })  : _spaceRepository = spaceRepository,
        super(const GetMySpaceEventRequestsState.initial()) {
    on<_GetMySpaceEventRequestsEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    _GetMySpaceEventRequestsEventFetch event,
    Emitter<GetMySpaceEventRequestsState> emit,
  ) async {
    emit(const GetMySpaceEventRequestsState.loading());

    final result = await _spaceRepository.getMySpaceEventRequests(
      input: Variables$Query$GetMySpaceEventRequests(
        space: event.spaceId,
        state: event.state,
        limit: event.limit,
        skip: event.skip,
      ),
    );

    result.fold(
      (failure) => emit(GetMySpaceEventRequestsState.failure(failure)),
      (response) => emit(GetMySpaceEventRequestsState.success(response)),
    );
  }
}
