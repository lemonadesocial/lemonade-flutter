import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_post_comments_input.freezed.dart';
part 'get_post_comments_input.g.dart';

@freezed
class GetPostCommentsInput with _$GetPostCommentsInput {
  @JsonSerializable(includeIfNull: false)
  factory GetPostCommentsInput({
    required String post,
    int? skip,
    int? limit,
  }) = _GetPostCommentsInput;

  factory GetPostCommentsInput.fromJson(Map<String, dynamic> json) =>
      _$GetPostCommentsInputFromJson(json);
}
