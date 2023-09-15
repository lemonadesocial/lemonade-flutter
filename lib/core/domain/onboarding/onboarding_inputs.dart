import 'package:app/core/domain/common/common_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_inputs.freezed.dart';

part 'onboarding_inputs.g.dart';

@freezed
class GetProfileInput with _$GetProfileInput {
  factory GetProfileInput({String? id, String? username}) = _GetProfileInput;

  factory GetProfileInput.fromJson(Map<String, dynamic> json) =>
      _$GetProfileInputFromJson(json);
}

@freezed
class UpdateUserProfileInput with _$UpdateUserProfileInput {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory UpdateUserProfileInput({
    String? username,
    @JsonKey(name: 'new_photos') List<String>? uploadPhoto,
    LemonPronoun? pronoun,
    String? displayName,
    @JsonKey(name: 'description') String? shortBio,
    String? ethnicity,
    String? educationTitle,
    String? industry,
    String? jobTitle,
    String? newGender,
    String? tagline,
    @JsonKey(name: 'date_of_birth') DateTime? dob,
    String? companyName,
  }) = _UpdateUserProfileInput;

  factory UpdateUserProfileInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileInputFromJson(json);
}
