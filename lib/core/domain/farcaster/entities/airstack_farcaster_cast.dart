import 'package:freezed_annotation/freezed_annotation.dart';

part 'airstack_farcaster_cast.freezed.dart';
part 'airstack_farcaster_cast.g.dart';

@freezed
class AirstackFarcasterCast with _$AirstackFarcasterCast {
  factory AirstackFarcasterCast({
    String? id,
    String? fid,
    String? text,
    String? url,
    List<Map<String, dynamic>>? embeds,
    String? hash,
    AirstackFarcasterUser? castedBy,
    AirstackFrame? frame,
    AirstackChannel? channel,
    List<AirstackFarcasterCast>? quotedCast,
    String? rootParentUrl,
    String? parentHash,
    String? parentFid,
    int? numberOfLikes,
    int? numberOfRecasts,
    int? numberOfReplies,
    DateTime? castedAtTimestamp,
  }) = _AirstackFarcasterCast;

  factory AirstackFarcasterCast.fromJson(Map<String, dynamic> json) =>
      _$AirstackFarcasterCastFromJson(json);
}

@freezed
class AirstackFarcasterUser with _$AirstackFarcasterUser {
  factory AirstackFarcasterUser({
    String? fid,
    String? profileName,
    String? profileImage,
    String? profileDisplayName,
    String? profileUrl,
    String? profileBio,
    int? followingCount,
    int? followerCount,
    String? location,
  }) = _AirstackFarcasterUser;

  factory AirstackFarcasterUser.fromJson(Map<String, dynamic> json) =>
      _$AirstackFarcasterUserFromJson(json);
}

@freezed
class AirstackFrame with _$AirstackFrame {
  factory AirstackFrame({
    String? imageUrl,
    String? frameUrl,
    String? postUrl,
    List<AirstackFrameButton>? buttons,
  }) = _AirstackFrame;

  factory AirstackFrame.fromJson(Map<String, dynamic> json) =>
      _$AirstackFrameFromJson(json);
}

@freezed
class AirstackFrameButton with _$AirstackFrameButton {
  factory AirstackFrameButton({
    int? index,
    AirstackFrameButtonAction? action,
    String? target,
    String? label,
  }) = _AirstackFrameButton;

  factory AirstackFrameButton.fromJson(Map<String, dynamic> json) =>
      _$AirstackFrameButtonFromJson(json);
}

enum AirstackFrameButtonAction {
  @JsonValue('post')
  post,
  @JsonValue('link')
  link,
  @JsonValue('post_redirect')
  postRedirect,
  @JsonValue('mint')
  mint,
  @JsonValue('tx')
  tx,
  @JsonValue('')
  unknown;

  static AirstackFrameButtonAction fromString(String value) {
    switch (value) {
      case 'post':
        return AirstackFrameButtonAction.post;
      case 'link':
        return AirstackFrameButtonAction.link;
      case 'post_redirect':
        return AirstackFrameButtonAction.postRedirect;
      case 'mint':
        return AirstackFrameButtonAction.mint;
      case 'tx':
        return AirstackFrameButtonAction.tx;
      default:
        return AirstackFrameButtonAction.unknown;
    }
  }
}

@freezed
class AirstackChannel with _$AirstackChannel {
  factory AirstackChannel({
    String? channelId,
    String? id,
    String? imageUrl,
    String? name,
    String? url,
  }) = _AirstackChannel;

  factory AirstackChannel.fromJson(Map<String, dynamic> json) =>
      _$AirstackChannelFromJson(json);
}
