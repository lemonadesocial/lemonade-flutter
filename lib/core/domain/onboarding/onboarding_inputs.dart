import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_inputs.freezed.dart';

part 'onboarding_inputs.g.dart';

@freezed
class GetProfileInput with _$GetProfileInput {
  factory GetProfileInput({String? userId, String? username}) = _GetProfileInput;

  factory GetProfileInput.fromJson(Map<String, dynamic> json) => _$GetProfileInputFromJson(json);
}

@freezed
class UpdateUserProfileInput with _$UpdateUserProfileInput {
  factory UpdateUserProfileInput({
    required String username,
    List<String>? uploadPhoto,
    OnboardingGender? gender,
    String? displayName,
    String? shortBio,
  }) = _UpdateUserProfileInput;

  factory UpdateUserProfileInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileInputFromJson(json);
}
