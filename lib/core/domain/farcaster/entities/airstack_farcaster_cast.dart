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
    String? id,
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
  }) = _AirstackFrame;

  factory AirstackFrame.fromJson(Map<String, dynamic> json) =>
      _$AirstackFrameFromJson(json);
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
