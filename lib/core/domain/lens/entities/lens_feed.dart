import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_feed.freezed.dart';
part 'lens_feed.g.dart';

@freezed
class LensFeed with _$LensFeed {
  const factory LensFeed({
    String? address,
    String? owner,
    String? createdAt,
    LensFeedMetadata? metadata,
  }) = _LensFeed;

  factory LensFeed.fromJson(Map<String, dynamic> json) =>
      _$LensFeedFromJson(json);
}

@freezed
class LensFeedMetadata with _$LensFeedMetadata {
  @JsonSerializable(explicitToJson: true)
  const factory LensFeedMetadata({
    String? id,
    String? name,
    String? description,
  }) = _LensFeedMetadata;

  factory LensFeedMetadata.fromJson(Map<String, dynamic> json) =>
      _$LensFeedMetadataFromJson(json);
}