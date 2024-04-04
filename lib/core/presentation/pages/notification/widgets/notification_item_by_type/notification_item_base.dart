import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:timeago/timeago.dart' as timeago;

class NotificationBaseItem extends StatelessWidget {
  final Widget? icon;
  final notification_entities.Notification notification;
  final Widget? avatar;
  final Widget? cover;
  final Widget? action;
  final Widget? extra;

  const NotificationBaseItem({
    super.key,
    required this.icon,
    required this.notification,
    this.avatar,
    this.cover,
    this.action,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final widgets =
        [avatar, cover].where((element) => element != null).toList();
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outline),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (avatar != null || cover != null || action != null)
                  SizedBox(
                    height: Spacing.extraSmall / 2,
                  ),
                icon!,
              ],
            ),
          ],
          SizedBox(width: Spacing.medium),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (avatar != null || cover != null || action != null) ...[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 2 * Sizing.medium + Spacing.extraSmall,
                        height: Sizing.medium,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widgets.length,
                          itemBuilder: (context, index) {
                            return widgets[index];
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: Spacing.extraSmall);
                          },
                        ),
                      ),
                      if (action != null) ...[
                        const Spacer(),
                        action!,
                      ],
                    ],
                  ),
                  SizedBox(height: Spacing.small),
                ],
                RichText(
                  text: TextSpan(
                    text: notification.message?.trim() ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                    children: [
                      TextSpan(
                        text:
                            ' ${timeago.format(notification.createdAt!, locale: 'en_short')}',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (extra != null) ...[
                  SizedBox(
                    height: Spacing.superExtraSmall,
                  ),
                  extra!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
