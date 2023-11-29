import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_ai_config_input.g.dart';
part 'get_ai_config_input.freezed.dart';

@freezed
class GetAIConfigInput with _$GetAIConfigInput {
  @JsonSerializable(
    includeIfNull: false,
  )
  factory GetAIConfigInput({
    String? id,
  }) = _GetAIConfigInput;

  factory GetAIConfigInput.fromJson(Map<String, dynamic> json) =>
      _$GetAIConfigInputFromJson(json);
}
