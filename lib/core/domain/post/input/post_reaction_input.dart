import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_reaction_input.freezed.dart';
part 'post_reaction_input.g.dart';

@freezed
class PostReactionInput with _$PostReactionInput {
  factory PostReactionInput({
    required String post,
    required bool active,
  }) = _PostReactionInput;

  factory PostReactionInput.fromJson(Map<String, dynamic> json) =>
      _$PostReactionInputFromJson(json);
}
