import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow_space_bloc.freezed.dart';

@freezed
class FollowSpaceEvent with _$FollowSpaceEvent {
  const factory FollowSpaceEvent.follow({
    required String spaceId,
  }) = _Follow;
  const factory FollowSpaceEvent.unfollow({
    required String spaceId,
  }) = _Unfollow;
  const factory FollowSpaceEvent.checkFollowed({
    required Space space,
  }) = _CheckFollowed;
}

@freezed
class FollowSpaceState with _$FollowSpaceState {
  const factory FollowSpaceState.loading() = FollowSpaceStateLoading;
  const factory FollowSpaceState.followed() = FollowSpaceStateFollowed;
  const factory FollowSpaceState.unfollowed() = FollowSpaceStateUnfollowed;
  const factory FollowSpaceState.failure(Failure failure) =
      FollowSpaceStateFailure;
}

class FollowSpaceBloc extends Bloc<FollowSpaceEvent, FollowSpaceState> {
  final SpaceRepository _spaceRepository;

  FollowSpaceBloc(this._spaceRepository)
      : super(const FollowSpaceState.unfollowed()) {
    on<_Follow>(_onFollow);
    on<_Unfollow>(_onUnfollow);
    on<_CheckFollowed>(_onCheckFollowed);
  }
  Future<void> _onFollow(_Follow event, Emitter emit) async {
    emit(const FollowSpaceState.loading());

    final result = await _spaceRepository.followSpace(spaceId: event.spaceId);

    result.fold(
      (failure) => emit(FollowSpaceState.failure(failure)),
      (success) => emit(const FollowSpaceState.followed()),
    );
  }

  Future<void> _onUnfollow(_Unfollow event, Emitter emit) async {
    emit(const FollowSpaceState.loading());

    final result = await _spaceRepository.unfollowSpace(spaceId: event.spaceId);

    result.fold(
      (failure) => emit(FollowSpaceState.failure(failure)),
      (success) => emit(const FollowSpaceState.unfollowed()),
    );
  }

  Future<void> _onCheckFollowed(_CheckFollowed event, Emitter emit) async {
    emit(const FollowSpaceState.loading());

    if (event.space.followed == true) {
      emit(const FollowSpaceState.followed());
    } else {
      emit(const FollowSpaceState.unfollowed());
    }
  }
}
