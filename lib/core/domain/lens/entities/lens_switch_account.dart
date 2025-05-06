import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_switch_account.freezed.dart';
part 'lens_switch_account.g.dart';

@freezed
sealed class LensSwitchAccountResult with _$LensSwitchAccountResult {
  const factory LensSwitchAccountResult.tokens({
    String? accessToken,
    String? refreshToken,
  }) = LensSwitchAccountTokens;

  const factory LensSwitchAccountResult.forbiddenError({
    String? reason,
  }) = LensForbiddenError;

  factory LensSwitchAccountResult.fromJson(Map<String, dynamic> json) =>
      _$LensSwitchAccountResultFromJson(json);
}
