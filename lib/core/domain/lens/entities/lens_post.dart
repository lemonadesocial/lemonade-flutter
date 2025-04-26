import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_media.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/graphql/lens/schema.graphql.dart';

part 'lens_post.freezed.dart';
part 'lens_post.g.dart';

@Freezed(unionKey: '__typename')
sealed class LensPostMetadata with _$LensPostMetadata {
  const LensPostMetadata._();

  String? get content {
    if (this is LensTextOnlyMetadata) {
      return (this as LensTextOnlyMetadata).content;
    }
    if (this is LensImageMetadata) {
      return (this as LensImageMetadata).content;
    }
    if (this is LensEventMetadata) {
      return (this as LensEventMetadata).content;
    }
    return null;
  }

  String? get title {
    if (this is LensTextOnlyMetadata) {
      return (this as LensTextOnlyMetadata).content;
    }
    if (this is LensImageMetadata) {
      return (this as LensImageMetadata).title;
    }
    if (this is LensEventMetadata) {
      return (this as LensEventMetadata).title;
    }
    return null;
  }

  String? get imageUrl {
    if (this is LensImageMetadata) {
      return (this as LensImageMetadata).image?.item;
    }
    return null;
  }

  @FreezedUnionValue('ImageMetadata')
  const factory LensPostMetadata.image({
    String? id,
    String? title,
    String? content,
    LensMediaImage? image,
    Enum$MainContentFocus? mainContentFocus,
    List<String>? tags,
    String? contentWarning,
  }) = LensImageMetadata;

  @FreezedUnionValue('TextOnlyMetadata')
  const factory LensPostMetadata.textOnly({
    String? id,
    String? content,
    Enum$MainContentFocus? mainContentFocus,
    List<String>? tags,
    String? contentWarning,
  }) = LensTextOnlyMetadata;

  @FreezedUnionValue('EventMetadata')
  const factory LensPostMetadata.event({
    String? id,
    String? title,
    String? content,
    DateTime? startsAt,
    DateTime? endsAt,
    List<String>? links,
    String? position,
    List<String>? tags,
    Enum$MainContentFocus? mainContentFocus,
    String? contentWarning,
  }) = LensEventMetadata;

  @JsonSerializable(explicitToJson: true)
  const factory LensPostMetadata.unknown({
    String? id,
    String? rawContent,
  }) = LensUnknownMetadata;

  factory LensPostMetadata.fromJson(Map<String, dynamic> json) =>
      _$LensPostMetadataFromJson(json);
}

@Freezed(unionKey: '__typename')
sealed class LensPostMention with _$LensPostMention {
  @FreezedUnionValue('AccountMention')
  const factory LensPostMention.account({
    String? account,
  }) = LensAccountMention;

  @FreezedUnionValue('GroupMention')
  const factory LensPostMention.group({
    String? group,
  }) = LensGroupMention;

  factory LensPostMention.fromJson(Map<String, dynamic> json) =>
      _$LensPostMentionFromJson(json);
}

@freezed
class LensPostFeedInfo with _$LensPostFeedInfo {
  @JsonSerializable(explicitToJson: true)
  const factory LensPostFeedInfo({
    String? address,
  }) = _LensPostFeedInfo;

  factory LensPostFeedInfo.fromJson(Map<String, dynamic> json) =>
      _$LensPostFeedInfoFromJson(json);
}

@freezed
class LensPostStats with _$LensPostStats {
  const factory LensPostStats({
    int? bookmarks,
    int? comments,
    int? reposts,
    int? quotes,
    int? collects,
    int? tips,
    int? reactions,
  }) = _LensPostStats;

  factory LensPostStats.fromJson(Map<String, dynamic> json) =>
      _$LensPostStatsFromJson(json);
}

@freezed
class LensPost with _$LensPost {
  const LensPost._();

  @JsonSerializable(explicitToJson: true)
  const factory LensPost({
    String? id,
    String? slug,
    LensAccount? author,
    LensPostFeedInfo? feed,
    bool? isEdited,
    bool? isDeleted,
    DateTime? timestamp,
    LensPostMetadata? metadata,
    LensPost? root,
    LensPost? quoteOf,
    LensPost? commentOn,
    List<LensPostMention>? mentions,
    LensPostStats? stats,
    String? contentUri,
  }) = _LensPost;

  factory LensPost.fromJson(Map<String, dynamic> json) =>
      _$LensPostFromJson(json);
}
