import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/theme/typo.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:timeago/timeago.dart' as timeago;
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';

class NotificationCard extends StatelessWidget {
  final notification_entities.Notification notification;
  final Function()? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: colorScheme.outline)),
          ),
          child: Row(
            children: [
              _buildAvatar(),
              Expanded(child: _buildMessage(colorScheme)),
              _buildOptionsButton(colorScheme),
            ],
          ),
        ));
  }

  Widget _buildAvatar() {
    if (notification.type == NotificationType.eventCohostRequest ||
        notification.type == NotificationType.userFriendshipRequest) {
      return Container(
        padding: EdgeInsets.only(right: Spacing.small),
        child: LemonCircleAvatar(
          url: ImageUtils.generateUrl(
              file: notification.fromExpanded?.newPhotosExpanded?.first,
              imageConfig: ImageConfig.profile),
          size: 42,
        ),
      );
    }
    if (notification.type == NotificationType.userDiscoveryMatch) {
      return Container(
          padding: EdgeInsets.only(right: Spacing.small),
          child: ThemeSvgIcon(
            color: const Color(0xFFC69DF7),
            builder: (filter) => Assets.icons.icMatches
                .svg(colorFilter: filter, width: 42, height: 42),
          ));
    }
    return Container();
  }

  Widget _buildMessage(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(notification.message ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            )),
        Text(timeago.format(notification.createdAt!, locale: 'en_short'),
            style: Typo.medium.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ))
      ],
    );
  }

  Widget _buildOptionsButton(ColorScheme colorScheme) {
    return IconButton(
      icon: ThemeSvgIcon(
        color: colorScheme.onSurfaceVariant,
        builder: (filter) => Assets.icons.icMoreHoriz.svg(
          colorFilter: filter,
        ),
      ),
      onPressed: () {},
    );
  }
}
