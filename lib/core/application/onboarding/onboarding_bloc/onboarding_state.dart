part of 'onboarding_bloc.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(OnboardingStatus.initial) OnboardingStatus status,
    bool? usernameExisted,
    String? username,
    XFile? profilePhoto,
    LemonPronoun? gender,
    String? aboutDisplayName,
    String? aboutShortBio,
    List<dynamic>? interestList,
  }) = _OnboardingState;

  factory OnboardingState.initial() => const OnboardingState();
}

enum OnboardingStatus {
  initial,
  loading,
  success,
  error,
}
