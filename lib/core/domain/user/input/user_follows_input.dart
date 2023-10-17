import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_follows_input.freezed.dart';
part 'user_follows_input.g.dart';

@freezed
class GetUserFollowsInput with _$GetUserFollowsInput {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory GetUserFollowsInput({
    String? followee,
    String? follower,
  }) = _GetUserFollowsInput;

  factory GetUserFollowsInput.fromJson(Map<String, dynamic> json) =>
      _$GetUserFollowsInputFromJson(json);
}
