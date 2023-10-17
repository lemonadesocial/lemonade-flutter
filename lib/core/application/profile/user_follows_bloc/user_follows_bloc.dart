import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
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
  }
  UserRepository userRepository;

  Future<void> _onFetch(UserFollowsEventFetch event, Emitter emit) async {
    final follower = getIt<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => null,
        );
    final result = await userRepository.getUserFollows(
      GetUserFollowsInput(
        followee: event.followee,
        follower: follower,
      ),
    );
    result.fold(
      (failure) => emit(UserFollowsState.failure()),
      (userProfile) => emit(
        UserFollowsState.fetched(userProfile: userProfile),
      ),
    );
  }
}

@freezed
class UserFollowsEvent with _$UserFollowsEvent {
  factory UserFollowsEvent.fetch({
    required String followee,
  }) = UserFollowsEventFetch;
}

@freezed
class UserFollowsState with _$UserFollowsState {
  factory UserFollowsState.loading() = UserFollowsStateLoading;

  factory UserFollowsState.fetched({required User userProfile}) =
      UserFollowsStateFetched;

  factory UserFollowsState.failure() = UserFollowsStateFailure;
}
