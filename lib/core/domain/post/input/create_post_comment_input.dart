import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_comment_input.freezed.dart';
part 'create_post_comment_input.g.dart';

@freezed
class CreatePostCommentInput with _$CreatePostCommentInput {
  factory CreatePostCommentInput({
    required String post,
    required String text,
  }) = _CreatePostCommentInput;

  factory CreatePostCommentInput.fromJson(Map<String, dynamic> json) =>
      _$CreatePostCommentInputFromJson(json);
}
