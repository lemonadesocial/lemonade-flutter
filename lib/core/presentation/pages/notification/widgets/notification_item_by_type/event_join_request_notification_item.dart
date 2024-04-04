import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;

class EventJoinRequestNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const EventJoinRequestNotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return NotificationBaseItem(
      notification: notification,
      icon: ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (colorFilter) => Assets.icons.icOutlineVerified.svg(
          colorFilter: colorFilter,
          width: Sizing.small,
          height: Sizing.small,
        ),
      ),
      avatar: NotificationThumbnail(
        imageUrl: '',
        onTap: () {
          // TODO: navigate to profile
        },
        radius: BorderRadius.circular(Sizing.medium),
      ),
      cover: NotificationThumbnail(
        imageUrl: '',
        onTap: () {
          // TODO: navigate to event
        },
      ),
      action: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (colorFilter) => _Icon(
              onTap: () {
                // TODO: view application
              },
              icon: Assets.icons.icApplication.svg(
                colorFilter: colorFilter,
              ),
            ),
          ),
          SizedBox(width: Spacing.extraSmall),
          ThemeSvgIcon(
            color: LemonColor.coralReef,
            builder: (colorFilter) => _Icon(
              onTap: () {
                //TODO: decline join request
              },
              icon: Assets.icons.icClose.svg(
                colorFilter: colorFilter,
              ),
            ),
          ),
          SizedBox(width: Spacing.extraSmall),
          ThemeSvgIcon(
            color: LemonColor.paleViolet,
            builder: (colorFilter) => _Icon(
              onTap: () {
                //TODO: Accept join request
              },
              icon: Assets.icons.icDone.svg(
                colorFilter: colorFilter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;

  const _Icon({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizing.medium,
        height: Sizing.medium,
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(Sizing.medium),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
