import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/post/post_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dtos.freezed.dart';
part 'post_dtos.g.dart';

@freezed
class PostDto with _$PostDto {
  @JsonSerializable(explicitToJson: true)
  const factory PostDto({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String user,
    required PostVisibility visibility,
    @JsonKey(name: 'user_expanded') UserDto? userExpanded,
    String? text,
    @JsonKey(name: 'ref_id') String? refId,
    @JsonKey(name: 'ref_type') PostRefType? refType,
    @JsonKey(name: 'ref_event') EventDto? refEvent,
    @JsonKey(name: 'ref_file') DbFileDto? refFile,
    @JsonKey(name: 'has_reaction') bool? hasReaction,
    int? reactions,
    int? comments,
    bool? published,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
}
