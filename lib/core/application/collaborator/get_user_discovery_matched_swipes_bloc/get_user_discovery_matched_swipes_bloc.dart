import 'package:app/core/domain/collaborator/collaborator_repository.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery_swipes.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_discovery_matched_swipes_bloc.freezed.dart';

class GetUserDiscoveryMatchedSwipesBloc extends Bloc<
    GetUserDiscoveryMatchedSwipesEvent, GetUserDiscoveryMatchedSwipesState> {
  GetUserDiscoveryMatchedSwipesBloc()
      : super(GetUserDiscoveryMatchedSwipesState.loading()) {
    on<_GetUserDiscoveryMatchedSwipesEventFetch>(_onFetch);
  }

  void _onFetch(
    _GetUserDiscoveryMatchedSwipesEventFetch event,
    Emitter emit,
  ) async {
    emit(
      GetUserDiscoveryMatchedSwipesState.loading(),
    );
    final result = await getIt<CollaboratorRepository>().getUserDiscoverySwipes(
      input: Variables$Query$GetUserDiscoverySwipes(
        skip: 0,
        limit: 100,
        state: Enum$UserDiscoverySwipeState.matched,
      ),
    );
    result.fold((l) {
      emit(
        GetUserDiscoveryMatchedSwipesState.failure(),
      );
    }, (matchedSwipes) {
      emit(
        GetUserDiscoveryMatchedSwipesState.fetched(
          matchedSwipes: matchedSwipes,
        ),
      );
    });
  }
}

@freezed
class GetUserDiscoveryMatchedSwipesEvent
    with _$GetUserDiscoveryMatchedSwipesEvent {
  factory GetUserDiscoveryMatchedSwipesEvent.fetch() =
      _GetUserDiscoveryMatchedSwipesEventFetch;
}

@freezed
class GetUserDiscoveryMatchedSwipesState
    with _$GetUserDiscoveryMatchedSwipesState {
  factory GetUserDiscoveryMatchedSwipesState.loading() =
      _GetUserDiscoveryMatchedSwipesStateLoading;
  factory GetUserDiscoveryMatchedSwipesState.failure() =
      _GetUserDiscoveryMatchedSwipesStateFailure;
  factory GetUserDiscoveryMatchedSwipesState.fetched({
    required List<UserDiscoverySwipe> matchedSwipes,
  }) = _GetUserDiscoveryMatchedSwipesStateFetched;
}
