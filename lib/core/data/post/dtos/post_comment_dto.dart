import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_dto.freezed.dart';
part 'post_comment_dto.g.dart';

@freezed
class PostCommentDto with _$PostCommentDto {
  factory PostCommentDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? user,
    String? text,
    String? post,
    @JsonKey(name: 'user_expanded') UserDto? userExpanded,
  }) = _PostCommentDto;

  factory PostCommentDto.fromJson(Map<String, dynamic> json) =>
      _$PostCommentDtoFromJson(json);
}
