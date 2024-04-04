import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;

class PaymentNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const PaymentNotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return NotificationBaseItem(
      notification: notification,
      icon: Builder(
        builder: (context) {
          if (notification.type ==
              Enum$NotificationType.payment_succeeded.name) {
            return ThemeSvgIcon(
              color: LemonColor.snackBarSuccess,
              builder: (colorFilter) => Assets.icons.icChecked.svg(
                colorFilter: colorFilter,
                width: Sizing.small,
                height: Sizing.small,
              ),
            );
          }

          if (notification.type == Enum$NotificationType.payment_failed.name) {
            return ThemeSvgIcon(
              color: LemonColor.coralReef,
              builder: (colorFilter) => Assets.icons.icInfo.svg(
                colorFilter: colorFilter,
                width: Sizing.small,
                height: Sizing.small,
              ),
            );
          }

          return ThemeSvgIcon(
            color: LemonColor.coralReef,
            builder: (colorFilter) => Assets.icons.icInfo.svg(
              colorFilter: colorFilter,
              width: Sizing.small,
              height: Sizing.small,
            ),
          );
        },
      ),
      cover: NotificationThumbnail(
        imageUrl: '',
        onTap: () {
          AutoRouter.of(context).push(
            EventDetailRoute(eventId: notification.refEvent ?? ''),
          );
        },
      ),
      action: Builder(
        builder: (context) {
          if (notification.type == Enum$NotificationType.payment_failed.name) {
            return InkWell(
              onTap: () {
                AutoRouter.of(context).push(
                  EventDetailRoute(eventId: notification.refEvent ?? ''),
                );
              },
              child: Container(
                width: Sizing.medium,
                height: Sizing.medium,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(Sizing.medium),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (colorFilter) => Assets.icons.icRefresh.svg(
                      colorFilter: colorFilter,
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
