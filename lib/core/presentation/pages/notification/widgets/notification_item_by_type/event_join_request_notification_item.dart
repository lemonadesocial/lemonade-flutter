import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
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
      avatar: notification.refUserExpanded != null
          ? NotificationThumbnail(
              imageUrl: notification.refUserExpanded?.imageAvatar ?? '',
              onTap: () {
                AutoRouter.of(context).push(
                  ProfileRoute(
                    userId: notification.refUserExpanded?.userId ?? '',
                  ),
                );
              },
              radius: BorderRadius.circular(Sizing.medium),
              placeholder: ImagePlaceholder.avatarPlaceholder(
                radius: BorderRadius.circular(Sizing.medium),
              ),
            )
          : null,
      cover: NotificationThumbnail(
        imageUrl: notification.refEventExpanded != null
            ? EventUtils.getEventThumbnailUrl(
                event: notification.refEventExpanded!,
              )
            : '',
        onTap: () {
          AutoRouter.of(context).push(
            EventDetailRoute(eventId: notification.refEventExpanded?.id ?? ''),
          );
        },
        placeholder: ImagePlaceholder.eventCard(),
      ),
      action:
          notification.type == Enum$NotificationType.event_request_created.name
              ? Row(
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
                )
              : const SizedBox.shrink(),
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
