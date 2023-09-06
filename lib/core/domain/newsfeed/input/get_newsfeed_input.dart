import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_newsfeed_input.freezed.dart';
part 'get_newsfeed_input.g.dart';

@freezed
class GetNewsfeedInput with _$GetNewsfeedInput {
  @JsonSerializable(explicitToJson: true)
  const factory GetNewsfeedInput({
    @JsonKey(includeIfNull: false) int? offset,
  }) = _GetNewsfeedInput;
  factory GetNewsfeedInput.fromJson(Map<String, dynamic> json) =>
      _$GetNewsfeedInputFromJson(json);
}

@freezed
class GetNewsfeedCreatedAtInput with _$GetNewsfeedCreatedAtInput {
  const factory GetNewsfeedCreatedAtInput({
    @JsonKey(includeIfNull: false) DateTime? gte,
    @JsonKey(includeIfNull: false) DateTime? lte,
  }) = _GetNewsfeedCreatedAtInput;
  factory GetNewsfeedCreatedAtInput.fromJson(Map<String, dynamic> json) =>
      _$GetNewsfeedCreatedAtInputFromJson(json);
}
