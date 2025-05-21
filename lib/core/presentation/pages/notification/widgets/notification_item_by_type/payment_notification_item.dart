import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:app/app_theme/app_theme.dart';

class PaymentNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const PaymentNotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    return NotificationBaseItem(
      notification: notification,
      icon: Builder(
        builder: (context) {
          if (notification.type ==
              Enum$NotificationType.payment_succeeded.name) {
            return ThemeSvgIcon(
              color: appColors.textSuccess,
              builder: (colorFilter) => Assets.icons.icChecked.svg(
                colorFilter: colorFilter,
                width: Sizing.s6,
                height: Sizing.s6,
              ),
            );
          }

          if (notification.type == Enum$NotificationType.payment_failed.name) {
            return ThemeSvgIcon(
              color: appColors.textError,
              builder: (colorFilter) => Assets.icons.icInfo.svg(
                colorFilter: colorFilter,
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
                  color: appColors.cardBg,
                  borderRadius: BorderRadius.circular(Sizing.medium),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: appColors.textTertiary,
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
