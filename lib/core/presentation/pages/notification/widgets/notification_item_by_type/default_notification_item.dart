import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:app/app_theme/app_theme.dart';

class DefaultNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const DefaultNotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return NotificationBaseItem(
      avatar: _buildAvatar(),
      icon: Builder(
        builder: (context) {
          if (notification.type == NotificationType.userDiscoveryMatch) {
            return ThemeSvgIcon(
              color: appColors.textAccent,
              builder: (filter) => Assets.icons.icMatches.svg(
                colorFilter: filter,
                width: Sizing.s6,
                height: Sizing.s6,
              ),
            );
          }

          return ThemeSvgIcon(
            color: appColors.textAlert,
            builder: (colorFilter) => Assets.icons.icInfo.svg(
              colorFilter: colorFilter,
              width: Sizing.s6,
              height: Sizing.s6,
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
            file:
                notification.fromExpanded?.newPhotosExpanded?.isNotEmpty == true
                    ? notification.fromExpanded?.newPhotosExpanded?.first
                    : null,
            imageConfig: ImageConfig.profile,
          ),
          size: Sizing.medium,
        ),
      );
    }

    return null;
  }
}
