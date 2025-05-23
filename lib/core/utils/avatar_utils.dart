import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/dice_bear_utils.dart';

class AvatarUtils {
  static String randomUserImage(String id) {
    return DiceBearUtils.getUserImageUrl(id: id);
  }

  static String getAvatarUrl({
    User? user,
    bool useRandomUserImage = true,
  }) {
    if (user != null && user.newPhotosExpanded?.isNotEmpty == true) {
      DbFile? photo = user.newPhotosExpanded?.isNotEmpty == true
          ? user.newPhotosExpanded![0]
          : null;
      return ImageUtils.generateUrl(file: photo);
    }
    if (user?.imageAvatar != null) {
      return user!.imageAvatar!;
    }
    if (useRandomUserImage) {
      return randomUserImage(user?.userId ?? '');
    }
    return '';
  }

  static String getProfileAvatar({
    required String? userAvatar,
    required String userId,
  }) {
    if (userAvatar != null) {
      return userAvatar;
    }
    return randomUserImage(userId);
  }
}
