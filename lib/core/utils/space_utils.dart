import 'package:app/core/domain/space/entities/space.dart';

class SpaceUtils {
  static String getSpaceImageUrl(Space? space) {
    final isPersonal = space?.personal ?? false;
    if (isPersonal) {
      return space?.creatorExpanded?.imageAvatar ?? '';
    }
    return space?.imageAvatar?.url ??
        space?.imageCover?.url ??
        space?.creatorExpanded?.imageAvatar ??
        '';
  }
}
