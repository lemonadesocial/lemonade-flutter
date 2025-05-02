import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_feed.freezed.dart';
part 'lens_feed.g.dart';

@freezed
class LensFeed with _$LensFeed {
  const factory LensFeed({
    /// A unique identifier that in storages like IPFS ensures the uniqueness of the metadata URI
    required String id,

    /// The name of the Feed
    required String name,

    /// Optional markdown formatted description of the Feed
    String? description,

    /// A cryptographic signature of the Lens metadata
    String? signature,
  }) = _LensFeed;

  factory LensFeed.fromJson(Map<String, dynamic> json) =>
      _$LensFeedFromJson(json);
}
