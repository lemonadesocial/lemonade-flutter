import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_input.freezed.dart';
part 'post_input.g.dart';

@freezed
class GetPostsInput with _$GetPostsInput {
  @JsonSerializable(explicitToJson: true)
  const factory GetPostsInput({
    @JsonKey(includeIfNull: false) FilterPostsInput? input,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
  }) = _GetPostsInput;
  factory GetPostsInput.fromJson(Map<String, dynamic> json) => _$GetPostsInputFromJson(json);
}

@freezed
class FilterPostsInput with _$FilterPostsInput {
  @JsonSerializable(explicitToJson: true)
  const factory FilterPostsInput({
    @JsonKey(name: '_id', includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) String? user,
    @JsonKey(includeIfNull: false) bool? published,
    @JsonKey(name: 'created_at', includeIfNull: false) GetPostCreatedAtInput? createdAt
  }) = _FilterPostsInput;
  factory FilterPostsInput.fromJson(Map<String, dynamic> json) => _$FilterPostsInputFromJson(json);
}

@freezed
class GetPostCreatedAtInput with _$GetPostCreatedAtInput {
  const factory GetPostCreatedAtInput({
    @JsonKey(includeIfNull: false) DateTime? gte,
    @JsonKey(includeIfNull: false) DateTime? lte,
  }) = _GetPostCreatedAtInput;
  factory GetPostCreatedAtInput.fromJson(Map<String, dynamic> json) => _$GetPostCreatedAtInputFromJson(json);
}
