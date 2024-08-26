import 'package:app/core/presentation/pages/notification/widgets/notification_item_by_type/notification_item_base.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_thumbnail.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;

class EventUpdateNotificationItem extends StatelessWidget {
  final notification_entities.Notification notification;
  const EventUpdateNotificationItem({
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
        color: LemonColor.paleViolet,
        builder: (colorFilter) => Assets.icons.icHouseParty.svg(
          colorFilter: colorFilter,
          width: Sizing.small,
          height: Sizing.small,
        ),
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
