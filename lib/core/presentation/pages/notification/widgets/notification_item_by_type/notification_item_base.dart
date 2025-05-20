import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/notification/entities/notification.dart'
    as notification_entities;
import 'package:timeago/timeago.dart' as timeago;
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final widgets =
        [avatar, cover].where((element) => element != null).toList();
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: appColors.pageDivider),
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    style: appText.md,
                    children: [
                      TextSpan(
                        text:
                            ' ${timeago.format(notification.createdAt!, locale: 'en_short')}',
                        style: appText.sm.copyWith(
                          color: appColors.textTertiary,
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
