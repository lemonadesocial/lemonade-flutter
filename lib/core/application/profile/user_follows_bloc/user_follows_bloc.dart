import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user_follow.dart';
import 'package:app/core/domain/user/input/user_follows_input.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_follows_bloc.freezed.dart';

class UserFollowsBloc extends Bloc<UserFollowsEvent, UserFollowsState> {
  UserFollowsBloc(
    this.userRepository,
  ) : super(UserFollowsState.loading()) {
    on<UserFollowsEventFetch>(_onFetch);
    on<UserFollowsEventFollow>(_onFollow);
    on<UserFollowsEventUnfollow>(_onUnfollow);
  }
  UserRepository userRepository;

  Future<void> _onFetch(UserFollowsEventFetch event, Emitter emit) async {
    final authSession = getIt<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final result = await userRepository.getUserFollows(
      GetUserFollowsInput(
        followee: event.followee,
        follower: authSession?.userId,
      ),
    );
    result.fold(
      (failure) => emit(UserFollowsState.failure()),
      (userFollows) => emit(
        UserFollowsState.fetched(userFollows: userFollows),
      ),
    );
  }

  Future<void> _onFollow(UserFollowsEventFollow event, Emitter emit) async {
    emit(UserFollowsState.loading());
    final authSession = getIt<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final result =
        await userRepository.createUserFollow(followee: event.followee);
    List<UserFollow> userFollows = [];
    userFollows.add(
      UserFollow(followee: event.followee, follower: authSession?.userId),
    );
    result.fold(
      (failure) => emit(UserFollowsState.failure()),
      (success) => emit(
        UserFollowsState.fetched(userFollows: userFollows),
      ),
    );
  }

  Future<void> _onUnfollow(UserFollowsEventUnfollow event, Emitter emit) async {
    emit(UserFollowsState.loading());
    final result =
        await userRepository.deleteUserFollow(followee: event.followee);
    result.fold(
      (failure) => emit(UserFollowsState.failure()),
      (success) => emit(
        UserFollowsState.fetched(userFollows: []),
      ),
    );
  }
}

@freezed
class UserFollowsEvent with _$UserFollowsEvent {
  factory UserFollowsEvent.fetch({
    required String followee,
  }) = UserFollowsEventFetch;

  factory UserFollowsEvent.follow({
    required String followee,
  }) = UserFollowsEventFollow;

  factory UserFollowsEvent.unfollow({
    required String followee,
  }) = UserFollowsEventUnfollow;
}

@freezed
class UserFollowsState with _$UserFollowsState {
  factory UserFollowsState.loading() = UserFollowsStateLoading;

  factory UserFollowsState.fetched({required List<UserFollow> userFollows}) =
      UserFollowsStateFetched;

  factory UserFollowsState.failure() = UserFollowsStateFailure;
}
