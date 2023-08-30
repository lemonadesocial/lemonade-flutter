import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_bloc.freezed.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {

  UserProfileBloc(
    this.userRepository,
  ) : super(UserProfileState.loading()) {
    on<UserProfileEventFetch>(_onFetch);
  }
  UserRepository userRepository;

  Future<void> _onFetch(UserProfileEventFetch event, Emitter emit) async {
    final result = await userRepository.getUserProfile(
      GetProfileInput(
        id: event.userId,
        // username: event.username,
      ),
    );
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
