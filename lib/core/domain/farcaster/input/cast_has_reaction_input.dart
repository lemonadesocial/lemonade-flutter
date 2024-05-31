import 'package:freezed_annotation/freezed_annotation.dart';

part 'cast_has_reaction_input.freezed.dart';
part 'cast_has_reaction_input.g.dart';

@freezed
class CastHasReactionInput with _$CastHasReactionInput {
  factory CastHasReactionInput({
    required int fid,
    @JsonKey(name: 'target_fid') required int targetFid,
    @JsonKey(name: 'target_hash') required String hash,
    @JsonKey(name: 'reaction_type')
    @Default('REACTION_TYPE_LIKE')
    String? reactionType,
  }) = _CastHasReactionInput;

  factory CastHasReactionInput.fromJson(Map<String, dynamic> json) =>
      _$CastHasReactionInputFromJson(json);
}
