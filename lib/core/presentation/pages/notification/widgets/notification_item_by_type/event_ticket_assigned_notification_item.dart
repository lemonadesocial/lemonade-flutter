import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;

class EventTicketAssignedNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const EventTicketAssignedNotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    final currentUserId = AuthUtils.getUserId(context);
    return NotificationBaseItem(
      notification: notification,
      icon: ThemeSvgIcon(
        color: appColors.textAccent,
        builder: (colorFilter) => Assets.icons.icTicketGradient.svg(
          colorFilter: colorFilter,
          width: Sizing.s6,
          height: Sizing.s6,
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
      action: LemonOutlineButton(
        onTap: () async {
          if (notification.refEventExpanded == null) {
            return;
          }
          if (EventUtils.isAttending(
            event: notification.refEventExpanded!,
            userId: currentUserId,
          )) {
            AutoRouter.of(context).push(
              MyEventTicketRoute(event: notification.refEventExpanded!),
            );
          } else {
            AutoRouter.of(context).pushAll([
              EventBuyTicketsRoute(event: notification.refEventExpanded!),
            ]);
          }
        },
        radius: BorderRadius.circular(LemonRadius.full),
        label: t.common.actions.viewTicket,
        height: Sizing.s8,
      ),
    );
  }
}
