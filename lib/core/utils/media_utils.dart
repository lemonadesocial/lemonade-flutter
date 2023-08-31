import 'dart:io';

import 'package:app/core/utils/ipfs_utils.dart';

enum MediaType {
  image,
  video,
  audio,
  unknown,
}

class Media {
  Media({
    required this.type,
    this.url,
  });
  final MediaType type;
  final String? url;
}

class MediaUtils {
  static Future<Media> getNftMedia(String? imageUrl, String? animationUrl) async {
    try {
      if (imageUrl == null && animationUrl == null) {
        return Media(type: MediaType.unknown);
      }
      if (imageUrl != null && animationUrl == null) {
        return Media(
          type: MediaType.image,
          url: IpfsUtils.getFetchableUrl(imageUrl).href,
        );
      }
      final fetchableUrl = IpfsUtils.getFetchableUrl(animationUrl ?? '');
      final protocol = fetchableUrl.protocol;
      final href = fetchableUrl.href;

      if (protocol == 'blob:') {
        final client = HttpClient();
        final request = await client.getUrl(Uri.parse(animationUrl ?? ''));
        final response = await request.close();
        final contentType = response.headers.contentType;

        if (contentType != null && contentType.value.startsWith('video/')) {
          return Media(
            type: MediaType.video,
            url: href,
          );
        }

        if (contentType != null && contentType.value.startsWith('audio/')) {
          return Media(
            type: MediaType.audio,
            url: href,
          );
        }

        if (contentType != null && contentType.value.startsWith('image/')) {
          return Media(
            type: MediaType.image,
            url: href,
          );
        }

        return Media(type: MediaType.unknown, url: href);
      }

      String? extension = href.split('.').last.toLowerCase();
      if (['gltf', 'glb', 'webm', 'mp4', 'm4v'].contains(extension)) {
        return Media(
          type: MediaType.video,
          url: href,
        );
      }

      if (['ogv', 'ogg', 'mp3', 'wav', 'oga'].contains(extension)) {
        return Media(
          type: MediaType.audio,
          url: href,
        );
      }

      if (['png', 'jpg', 'gif', 'jpeg', 'bmp', 'svg', 'webp'].contains(extension)) {
        return Media(
          type: MediaType.image,
          url: href,
        );
      }

      return Media(type: MediaType.unknown, url: href);
    } catch (e) {
      print('Caught error: $e');
      return Media(type: MediaType.unknown);
    }
  }
}
