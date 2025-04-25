import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_auth.freezed.dart';
part 'lens_auth.g.dart';

@freezed
class LensAuthenticationChallenge with _$LensAuthenticationChallenge {
  @JsonSerializable(explicitToJson: true)
  const factory LensAuthenticationChallenge({
    String? id,
    String? text,
  }) = _LensAuthenticationChallenge;

  factory LensAuthenticationChallenge.fromJson(Map<String, dynamic> json) =>
      _$LensAuthenticationChallengeFromJson(json);
}

@freezed
sealed class LensAuthenticationResult with _$LensAuthenticationResult {
  @JsonSerializable(explicitToJson: true)
  const factory LensAuthenticationResult.tokens({
    String? accessToken,
    String? refreshToken,
  }) = LensAuthenticationTokens;

  @JsonSerializable(explicitToJson: true)
  const factory LensAuthenticationResult.wrongSignerError({
    String? reason,
  }) = LensWrongSignerError;

  @JsonSerializable(explicitToJson: true)
  const factory LensAuthenticationResult.expiredChallengeError({
    String? reason,
  }) = LensExpiredChallengeError;

  @JsonSerializable(explicitToJson: true)
  const factory LensAuthenticationResult.forbiddenError({
    String? reason,
  }) = LensForbiddenError;

  factory LensAuthenticationResult.fromJson(Map<String, dynamic> json) =>
      _$LensAuthenticationResultFromJson(json);
}
