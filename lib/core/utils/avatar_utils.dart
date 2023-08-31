import 'package:app/core/config.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/image_utils.dart';

class AvatarUtils {
  static String randomImage(
    String id,
    int length,
    String Function(int) template,
  ) {
    int idLength = id.length;
    int hash = 0;
    for (int i = 0; i < idLength; i++) {
      hash += id.codeUnitAt(i);
    }
    return template((hash % length) + 1);
  }

  static String randomUserImage(String id) {
    return randomImage(
      id,
      10,
      (num) =>
          '${AppConfig.assetPrefix}/assets/images/avatars/lemonade_davatar_$num.png',
    );
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
      return randomUserImage(user?.id ?? '');
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
