import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;

class DefaultNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const DefaultNotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationBaseItem(
      avatar: _buildAvatar(),
      icon: Builder(
        builder: (context) {
          if (notification.type == NotificationType.userDiscoveryMatch) {
            return Container(
              padding: EdgeInsets.only(right: Spacing.small),
              child: ThemeSvgIcon(
                color: const Color(0xFFC69DF7),
                builder: (filter) => Assets.icons.icMatches.svg(
                  colorFilter: filter,
                  width: Sizing.medium,
                  height: Sizing.medium,
                ),
              ),
            );
          }

          return ThemeSvgIcon(
            color: LemonColor.aero,
            builder: (colorFilter) => Assets.icons.icInfo.svg(
              colorFilter: colorFilter,
            ),
          );
        },
      ),
      notification: notification,
    );
  }

  Widget? _buildAvatar() {
    if (notification.type == NotificationType.eventCohostRequest ||
        notification.type == NotificationType.userFriendshipRequest ||
        notification.type == NotificationType.eventAnnounce) {
      return Container(
        padding: EdgeInsets.only(right: Spacing.small),
        child: LemonCircleAvatar(
          url: ImageUtils.generateUrl(
            file: notification.fromExpanded?.newPhotosExpanded?.first,
            imageConfig: ImageConfig.profile,
          ),
          size: Sizing.medium,
        ),
      );
    }

    return null;
  }
}
