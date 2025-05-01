import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_create_post_metadata.freezed.dart';
part 'lens_create_post_metadata.g.dart';

@freezed
sealed class LensCreatePostMetadata with _$LensCreatePostMetadata {
  const factory LensCreatePostMetadata.textOnly({
    required String id,
    @Default('en') String locale,
    @Default(Enum$MainContentFocus.TEXT_ONLY)
    Enum$MainContentFocus mainContentFocus,
    required String content,
  }) = _LensCreatePostMetadataTextOnly;

  factory LensCreatePostMetadata.fromJson(Map<String, dynamic> json) =>
      _$LensCreatePostMetadataFromJson(json);
}
