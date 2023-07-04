import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_bloc.freezed.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserRepository userRepository;
  UserProfileBloc(
    this.userRepository,
  ) : super(UserProfileState.loading()) {
    on<UserProfileEventFetch>(_onFetch);
  }

  _onFetch(UserProfileEventFetch event, Emitter emit) async {
    var result = await userRepository.getUserProfile(userId: event.userId, username: event.username);
    result.fold(
      (failure) => emit(UserProfileState.failure()),
      (userProfile) => emit(
        UserProfileState.fetched(userProfile: userProfile),
      ),
    );
  }
}

@freezed
class UserProfileEvent with _$UserProfileEvent {
  factory UserProfileEvent.fetch({
    String? userId,
    String? username,
  }) = UserProfileEventFetch;
}

@freezed
class UserProfileState with _$UserProfileState {
  factory UserProfileState.loading() = UserProfileStateLoading;
  factory UserProfileState.fetched({required User userProfile}) = UserProfileStateFetched;
  factory UserProfileState.failure() = UserProfileStateFailure;
}
