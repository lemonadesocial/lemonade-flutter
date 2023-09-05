import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_posts_input.freezed.dart';
part 'get_posts_input.g.dart';

@freezed
class GetPostsInput with _$GetPostsInput {
  @JsonSerializable(explicitToJson: true)
  const factory GetPostsInput({
    @JsonKey(name: '_id', includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) String? user,
    @JsonKey(includeIfNull: false) bool? published,
    @JsonKey(name: 'created_at', includeIfNull: false)
    GetPostCreatedAtInput? createdAt,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
  }) = _GetPostsInput;
  factory GetPostsInput.fromJson(Map<String, dynamic> json) =>
      _$GetPostsInputFromJson(json);
}

@freezed
class GetPostCreatedAtInput with _$GetPostCreatedAtInput {
  const factory GetPostCreatedAtInput({
    @JsonKey(includeIfNull: false) DateTime? gte,
    @JsonKey(includeIfNull: false) DateTime? lte,
  }) = _GetPostCreatedAtInput;
  factory GetPostCreatedAtInput.fromJson(Map<String, dynamic> json) =>
      _$GetPostCreatedAtInputFromJson(json);
}
