import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;

class EventInvitedNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const EventInvitedNotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return NotificationBaseItem(
      notification: notification,
      icon: ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (colorFilter) => Assets.icons.icPersonAddOutline.svg(
          colorFilter: colorFilter,
          width: Sizing.small,
          height: Sizing.small,
        ),
      ),
      avatar: NotificationThumbnail(
        imageUrl: ImageUtils.generateUrl(
          file: notification.fromExpanded?.newPhotosExpanded?.isNotEmpty == true
              ? notification.fromExpanded?.newPhotosExpanded!.first
              : null,
        ),
        onTap: () {
          AutoRouter.of(context).push(
            ProfileRoute(
              userId: notification.from ?? '',
            ),
          );
        },
        radius: BorderRadius.circular(Sizing.medium),
      ),
      cover: NotificationThumbnail(
        imageUrl: '',
        onTap: () {
          AutoRouter.of(context).push(
            EventDetailRoute(eventId: notification.refEvent ?? ''),
          );
        },
      ),
      action: LemonOutlineButton(
        onTap: () async {
          AutoRouter.of(context).push(
            EventDetailRoute(eventId: notification.refEvent ?? ''),
          );
        },
        backgroundColor: colorScheme.secondaryContainer,
        radius: BorderRadius.circular(LemonRadius.button),
        borderColor: Colors.transparent,
        label: t.common.actions.viewEvent,
      ),
    );
  }
}
