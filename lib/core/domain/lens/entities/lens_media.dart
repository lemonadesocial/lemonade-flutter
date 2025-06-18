import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_media.freezed.dart';
part 'lens_media.g.dart';

@Freezed(unionKey: '__typename')
sealed class LensAnyMedia with _$LensAnyMedia {
  const LensAnyMedia._();

  bool get isImage => this is LensMediaImage;

  @FreezedUnionValue('MediaImage')
  const factory LensAnyMedia.image({
    int? width,
    int? height,
    Enum$MediaImageType? type,
    String? item,
    String? altTag,
  }) = LensMediaImage;

  @FreezedUnionValue('MediaVideo')
  const factory LensAnyMedia.video({
    String? item,
    String? altTag,
    Enum$MediaVideoType? type,
  }) = LensMediaVideo;

  @FreezedUnionValue('MediaAudio')
  const factory LensAnyMedia.audio({
    String? item,
    String? altTag,
    Enum$MediaAudioType? type,
  }) = LensMediaAudio;

  factory LensAnyMedia.fromJson(Map<String, dynamic> json) =>
      _$LensAnyMediaFromJson(json);
}
