import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_safe_free_limit_input.freezed.dart';
part 'get_safe_free_limit_input.g.dart';

@freezed
class GetSafeFreeLimitInput with _$GetSafeFreeLimitInput {
  factory GetSafeFreeLimitInput({
    required String network,
  }) = _GetSafeFreeLimitInput;

  factory GetSafeFreeLimitInput.fromJson(Map<String, dynamic> json) =>
      _$GetSafeFreeLimitInputFromJson(json);
}
