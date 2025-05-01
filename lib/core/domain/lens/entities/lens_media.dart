import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_media.freezed.dart';
part 'lens_media.g.dart';

@freezed
abstract class LensMediaImage with _$LensMediaImage {
  const factory LensMediaImage({
    int? width,
    int? height,
    Enum$MediaImageType? type,
    String? item,
    String? altTag,
  }) = _LensMediaImage;

  factory LensMediaImage.fromJson(Map<String, dynamic> json) =>
      _$LensMediaImageFromJson(json);
}
