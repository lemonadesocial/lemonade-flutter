import 'package:freezed_annotation/freezed_annotation.dart';

part 'cast_has_reaction_input.freezed.dart';
part 'cast_has_reaction_input.g.dart';

enum CheckHasReactionType {
  @JsonValue('REACTION_TYPE_LIKE')
  like,
  @JsonValue('REACTION_TYPE_RECAST')
  recast,
}

@freezed
class CastHasReactionInput with _$CastHasReactionInput {
  factory CastHasReactionInput({
    required int fid,
    @JsonKey(name: 'target_fid') required int targetFid,
    @JsonKey(name: 'target_hash') required String hash,
    @JsonKey(name: 'reaction_type')
    @Default(CheckHasReactionType.like)
    CheckHasReactionType? reactionType,
  }) = _CastHasReactionInput;

  factory CastHasReactionInput.fromJson(Map<String, dynamic> json) =>
      _$CastHasReactionInputFromJson(json);
}
