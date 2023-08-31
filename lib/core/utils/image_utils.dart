
import 'dart:convert';

import 'package:app/core/domain/common/entities/common.dart';

class EditProps {

  EditProps({this.resize});
  final Map<String, dynamic>? resize;
}

enum ImageConfig {
  eventPhoto,
  profile,
  profileCover,
  eventPoster,
  fullScreen,
  discoveryImage,
  discoveryProfileImage,
  userPhoto,
  userCoverBanner,
  ticketPhoto,
  streamPhoto,
}

final editMap = {
  ImageConfig.eventPhoto: EditProps(resize: {'height': 540, 'fit': 'cover'}),
  ImageConfig.profile: EditProps(resize: {'height': 360, 'width': 360, 'fit': 'cover'}),
  ImageConfig.profileCover: EditProps(resize: {'height': 720, 'width': 720, 'fit': 'cover'}),
  ImageConfig.eventPoster: EditProps(resize: {'height': 960, 'fit': 'cover'}),
  ImageConfig.fullScreen: EditProps(resize: {'height': 1080, 'fit': 'cover'}),
  ImageConfig.discoveryImage: EditProps(resize: {'width': 357, 'fit': 'cover'}),
  ImageConfig.discoveryProfileImage: EditProps(resize: {'height': 669, 'width': 357, 'fit': 'cover'}),
  ImageConfig.userPhoto: EditProps(resize: {'height': 512, 'width': 512, 'fit': 'cover'}),
  ImageConfig.userCoverBanner: EditProps(resize: {'width': 1280, 'fit': 'cover'}),
  ImageConfig.ticketPhoto: EditProps(resize: {'width': 135, 'fit': 'cover'}),
  ImageConfig.streamPhoto: EditProps(resize: {'height': 189, 'width': 336, 'fit': 'cover'}),
};

class ImageUtils {
  static String generateUrl({DbFile? file, ImageConfig? imageConfig}) {
    if (file == null || file.bucket == null || file.key == null) return '';

    if (file.type == 'image/gif') {
      return file.url ?? '';
    }

    final url = (file.bucket ?? '').contains('eu-west-1')
        ? 'https://images.staging.lemonade.social'
        : 'https://images.lemonade.social';

    final params = <String, dynamic>{
      'bucket': file.bucket,
      'key': file.key,
    };

    if (imageConfig != null) {
      params['edits'] = {
        'resize': editMap[imageConfig]!.resize
      };
    }
    final a = json.encode(params);
    return '$url/${base64.encode(utf8.encode(json.encode(params)))}';
  }
}