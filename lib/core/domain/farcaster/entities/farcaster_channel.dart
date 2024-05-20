import 'package:freezed_annotation/freezed_annotation.dart';

part 'farcaster_channel.freezed.dart';
part 'farcaster_channel.g.dart';

@freezed
class FarcasterChannel with _$FarcasterChannel {
  factory FarcasterChannel({
    String? id,
    String? url,
    String? name,
    String? description,
    String? imageUrl,
    double? followerCount,
  }) = _FarcasterChannel;

  factory FarcasterChannel.fromJson(Map<String, dynamic> json) =>
      _$FarcasterChannelFromJson(json);
}
