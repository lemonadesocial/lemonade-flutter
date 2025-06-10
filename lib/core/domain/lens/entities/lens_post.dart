import 'package:app/core/config.dart';
import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_boolean_value.dart';
import 'package:app/core/domain/lens/entities/lens_media.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/graphql/lens/schema.graphql.dart';

part 'lens_post.freezed.dart';
part 'lens_post.g.dart';

String? _extractLemonadeEventLink(String link) {
  final uri = Uri.parse(link);
  if (uri.origin.contains(AppConfig.webUrl) &&
      uri.pathSegments.length > 1 &&
      uri.pathSegments.first == 'e') {
    final shortId = uri.pathSegments.last;
    return '${AppConfig.webUrl}/api/og/event/$shortId';
  }
  return null;
}

@Freezed(unionKey: '__typename', fallbackUnion: 'unknown')
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
    if (this is LensLinkMetadata) {
      return (this as LensLinkMetadata).content;
    }
    return null;
  }

  String? get title {
    if (this is LensTextOnlyMetadata) {
      return (this as LensTextOnlyMetadata).title;
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

  List<String> get attachedImages {
    if (this is LensImageMetadata) {
      return ((this as LensImageMetadata).attachments ?? [])
          .whereType<LensMediaImage>()
          .map((e) => e.item)
          .whereType<String>()
          .toList();
    }
    if (this is LensEventMetadata) {
      return ((this as LensEventMetadata).attachments ?? [])
          .whereType<LensMediaImage>()
          .map((e) => e.item)
          .whereType<String>()
          .toList();
    }
    if (this is LensLinkMetadata) {
      return ((this as LensLinkMetadata).attachments ?? [])
          .whereType<LensMediaImage>()
          .map((e) => e.item)
          .whereType<String>()
          .toList();
    }
    return [];
  }

  String? get lemonadeEventLink {
    if (this is LensLinkMetadata) {
      final link = (this as LensLinkMetadata).sharingLink ?? '';
      if (link.isEmpty) {
        return null;
      }
      return _extractLemonadeEventLink(link);
    }
    if (this is LensEventMetadata) {
      if ((this as LensEventMetadata).links?.isNotEmpty == true) {
        String? foundedLink;
        for (final link in (this as LensEventMetadata).links!) {
          foundedLink = _extractLemonadeEventLink(link);
          if (foundedLink != null) {
            break;
          }
        }
        return foundedLink;
      }
    }
    return null;
  }

  @FreezedUnionValue('ImageMetadata')
  const factory LensPostMetadata.image({
    String? id,
    String? title,
    String? content,
    LensMediaImage? image,
    List<LensAnyMedia>? attachments,
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
    List<LensAnyMedia>? attachments,
  }) = LensEventMetadata;

  @FreezedUnionValue('LinkMetadata')
  const factory LensPostMetadata.link({
    String? id,
    String? content,
    String? sharingLink,
    List<String>? tags,
    Enum$MainContentFocus? mainContentFocus,
    String? contentWarning,
    List<LensAnyMedia>? attachments,
  }) = LensLinkMetadata;

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
class LensPostOperationValidationOutcome
    with _$LensPostOperationValidationOutcome {
  factory LensPostOperationValidationOutcome({
    bool? passed,
  }) = _LensPostOperationValidationOutcome;

  factory LensPostOperationValidationOutcome.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LensPostOperationValidationOutcomeFromJson(json);
}

@freezed
class LensLoggedInPostOperations with _$LensLoggedInPostOperations {
  @JsonSerializable(explicitToJson: true)
  const factory LensLoggedInPostOperations({
    bool? hasReacted,
    bool? hasBookmarked,
    LensBooleanValue? hasReposted,
    LensPostOperationValidationOutcome? canDelete,
  }) = _LensLoggedInPostOperations;

  factory LensLoggedInPostOperations.fromJson(Map<String, dynamic> json) =>
      _$LensLoggedInPostOperationsFromJson(json);
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
    LensLoggedInPostOperations? operations,
  }) = _LensPost;

  factory LensPost.fromJson(Map<String, dynamic> json) =>
      _$LensPostFromJson(json);
}
