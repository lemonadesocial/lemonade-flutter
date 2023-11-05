import 'package:app/core/application/notification/delete_notifications_bloc/delete_notifications_bloc.dart';
import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/domain/notification/input/delete_notifications_input.dart';
import 'package:app/core/presentation/pages/notification/widgets/notification_slidable_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/theme/typo.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';

class NotificationCard extends StatelessWidget {
  final notification_entities.Notification notification;
  final int index;
  final Function()? onTap;
  final Function(
    int index,
    notification_entities.Notification notification,
    bool? isDismiss,
  )? onRemove;

  const NotificationCard({
    super.key,
    required this.index,
    required this.notification,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteNotificationsBloc(),
      child: NotificationCardView(
        index: index,
        notification: notification,
        onTap: onTap,
        onRemove: onRemove,
      ),
    );
  }
}

class NotificationCardView extends StatelessWidget {
  final notification_entities.Notification notification;
  final int index;
  final Function()? onTap;
  final Function(
    int index,
    notification_entities.Notification notification,
    bool? isDismiss,
  )? onRemove;

  const NotificationCardView({
    super.key,
    required this.index,
    required this.notification,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return NotificationSlidable(
      id: notification.id ?? '',
      onRemove: () {
        context.read<DeleteNotificationsBloc>().add(
              DeleteNotificationsEvent.delete(
                input: DeleteNotificationsInput(
                  ids: [notification.id ?? ''],
                ),
              ),
            );
        onRemove?.call(
          index,
          notification,
          false,
        );
      },
      onDismissed: () {
        context.read<DeleteNotificationsBloc>().add(
              DeleteNotificationsEvent.delete(
                input: DeleteNotificationsInput(
                  ids: [notification.id ?? ''],
                ),
              ),
            );
        onRemove?.call(
          index,
          notification,
          true,
        );
      },
      child: GestureDetector(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
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
        ),
      );
    }
    return Container();
  }

  Widget _buildMessage(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notification.message ?? '',
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          timeago.format(notification.createdAt!, locale: 'en_short'),
          style: Typo.medium.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
