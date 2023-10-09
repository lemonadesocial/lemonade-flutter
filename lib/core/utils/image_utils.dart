import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/core/domain/common/entities/common.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProps {
  final Map<String, dynamic>? resize;

  EditProps({this.resize});
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
  ImageConfig.profile:
      EditProps(resize: {'height': 360, 'width': 360, 'fit': 'cover'}),
  ImageConfig.profileCover:
      EditProps(resize: {'height': 720, 'width': 720, 'fit': 'cover'}),
  ImageConfig.eventPoster: EditProps(resize: {'height': 960, 'fit': 'cover'}),
  ImageConfig.fullScreen: EditProps(resize: {'height': 1080, 'fit': 'cover'}),
  ImageConfig.discoveryImage: EditProps(resize: {'width': 357, 'fit': 'cover'}),
  ImageConfig.discoveryProfileImage:
      EditProps(resize: {'height': 669, 'width': 357, 'fit': 'cover'}),
  ImageConfig.userPhoto:
      EditProps(resize: {'height': 512, 'width': 512, 'fit': 'cover'}),
  ImageConfig.userCoverBanner:
      EditProps(resize: {'width': 1280, 'fit': 'cover'}),
  ImageConfig.ticketPhoto: EditProps(resize: {'width': 135, 'fit': 'cover'}),
  ImageConfig.streamPhoto:
      EditProps(resize: {'height': 189, 'width': 336, 'fit': 'cover'}),
};

class ImageUtils {
  static String generateUrl({DbFile? file, ImageConfig? imageConfig}) {
    if (file == null || file.bucket == null || file.key == null) return '';

    if (file.type == 'image/gif') {
      return file.url ?? '';
    }

    String url = (file.bucket ?? '').contains('eu-west-1')
        ? 'https://images.staging.lemonade.social'
        : 'https://images.lemonade.social';

    Map<String, dynamic> params = {
      'bucket': file.bucket,
      'key': file.key,
    };

    if (imageConfig != null) {
      params['edits'] = {'resize': editMap[imageConfig]!.resize};
    }
    return '$url/${base64.encode(utf8.encode(json.encode(params)))}';
  }

  static Future<XFile> urlToFile(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    return XFile.fromData(response.bodyBytes, mimeType: 'image/png');
  }
}

Future<XFile?> getImageFromGallery({bool cropRequired = false}) async {
  final imagePicker = ImagePicker();
  final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
  if (pickImage == null) return null;

  if (cropRequired) {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          showCancelConfirmationDialog: true,
        ),
      ],
    );
    if (croppedFile == null) return null;
    final xFile = XFile(croppedFile.path);
    return xFile;
  }
  return pickImage;
}
