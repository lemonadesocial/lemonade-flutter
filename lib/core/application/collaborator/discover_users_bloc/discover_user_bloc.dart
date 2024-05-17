import 'package:app/core/domain/collaborator/collaborator_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/location_utils.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_user_bloc.freezed.dart';

class DiscoverUserBloc extends Bloc<DiscoverUserEvent, DiscoverUserState> {
  final _collaboratorRepository = getIt<CollaboratorRepository>();
  DiscoverUserBloc()
      : super(
          DiscoverUserState(
            fetching: true,
            users: [],
            filteredOfferings: [],
          ),
        ) {
    on<_DiscoverUserEventFetchUser>(_onFetch);
    on<_DiscoverUserEventOnUserSwiped>(_onUserSwiped);
    on<_DiscoverUserEventOnUpdateFilter>(_onUpdateFilter);
  }

  void _onFetch(_DiscoverUserEventFetchUser event, Emitter emit) async {
    final hasPermission = await getIt<LocationUtils>().checkPermission();
    double lat = 0;
    double lng = 0;
    if (!hasPermission) {
      return;
    }

    if (hasPermission) {
      final currentLocation = await getIt<LocationUtils>().getCurrentLocation();
      lat = currentLocation.latitude;
      lng = currentLocation.longitude;
    }

    emit(
      state.copyWith(fetching: true),
    );
    final result = await _collaboratorRepository.getUserDiscovery(
      input: Variables$Query$GetUserDiscovery(
        latitude: lat,
        longitude: lng,
        offerings:
            state.filteredOfferings.isEmpty ? null : state.filteredOfferings,
      ),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          fetching: false,
        ),
      ),
      (userDisocvery) {
        emit(
          state.copyWith(
            fetching: false,
            users: userDisocvery.selectedExpanded ?? [],
          ),
        );
      },
    );
  }

  void _onUserSwiped(_DiscoverUserEventOnUserSwiped event, Emitter emit) {
    final newUsers =
        state.users.where((element) => element.userId != event.userId).toList();
    if (newUsers.isEmpty) {
      add(DiscoverUserEvent.fetch());
    }
    emit(
      state.copyWith(
        fetching: newUsers.isEmpty,
        users: newUsers,
      ),
    );
  }

  void _onUpdateFilter(_DiscoverUserEventOnUpdateFilter event, Emitter emit) {
    emit(
      state.copyWith(filteredOfferings: event.filteredOfferings),
    );
    add(DiscoverUserEvent.fetch());
  }
}

@freezed
class DiscoverUserEvent with _$DiscoverUserEvent {
  factory DiscoverUserEvent.fetch() = _DiscoverUserEventFetchUser;
  factory DiscoverUserEvent.onUserSwiped({
    required String userId,
  }) = _DiscoverUserEventOnUserSwiped;
  factory DiscoverUserEvent.onUpdateFilter({
    required List<String> filteredOfferings,
  }) = _DiscoverUserEventOnUpdateFilter;
}

@freezed
class DiscoverUserState with _$DiscoverUserState {
  factory DiscoverUserState({
    required bool fetching,
    required List<User> users,
    required List<String> filteredOfferings,
  }) = _DiscoverUserState;
}
