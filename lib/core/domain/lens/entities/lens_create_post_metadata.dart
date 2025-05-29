import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_create_post_metadata.freezed.dart';
part 'lens_create_post_metadata.g.dart';

@freezed
class LensCreatePostMetadata with _$LensCreatePostMetadata {
  const LensCreatePostMetadata._();

  @JsonSerializable(explicitToJson: true)
  const factory LensCreatePostMetadata.textOnly({
    required String id,
    @Default('en') String locale,
    @Default(Enum$MainContentFocus.TEXT_ONLY)
    Enum$MainContentFocus mainContentFocus,
    required String content,
  }) = _LensCreatePostMetadataTextOnly;

  @JsonSerializable(explicitToJson: true)
  const factory LensCreatePostMetadata.image({
    required String id,
    @Default('en') String locale,
    @Default(Enum$MainContentFocus.IMAGE)
    Enum$MainContentFocus mainContentFocus,
    String? content,
    required LensMediaImageMetadata image,
  }) = _LensCreatePostMetadataImage;

  factory LensCreatePostMetadata.fromJson(Map<String, dynamic> json) =>
      _$LensCreatePostMetadataFromJson(json);
}

@freezed
class LensMediaImageMetadata with _$LensMediaImageMetadata {
  const LensMediaImageMetadata._();

  @JsonSerializable(explicitToJson: true)
  const factory LensMediaImageMetadata({
    required String item,
    required String type,
  }) = _LensMediaImageMetadata;

  factory LensMediaImageMetadata.fromJson(Map<String, dynamic> json) =>
      _$LensMediaImageMetadataFromJson(json);
}
