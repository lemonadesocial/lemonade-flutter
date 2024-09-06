import 'package:app/core/presentation/pages/notification/widgets/notifications_list_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

enum PendingInviteType {
  all,
  cohostRequest,
  eventInvite,
  friendRequest,
}

@RoutePage()
class HomePendingInvitesPage extends StatefulWidget {
  const HomePendingInvitesPage({super.key});

  @override
  State<HomePendingInvitesPage> createState() => _HomePendingInvitesPageState();
}

class _HomePendingInvitesPageState extends State<HomePendingInvitesPage> {
  PendingInviteType _selectedType = PendingInviteType.all;
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        title: t.home.pendingInvites.title,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Sizing.medium,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: PendingInviteType.values.length,
              separatorBuilder: (context, index) => SizedBox(
                width: Spacing.extraSmall,
              ),
              itemBuilder: (context, index) {
                String label = '';
                Widget? leading;
                bool isSelected =
                    PendingInviteType.values[index] == _selectedType;
                Color color = isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSecondary;
                switch (PendingInviteType.values[index]) {
                  case PendingInviteType.all:
                    label = t.common.all;
                    break;
                  case PendingInviteType.cohostRequest:
                    label = t.home.pendingInvites.cohostRequest;
                    leading = ThemeSvgIcon(
                      color: color,
                      builder: (filter) => Assets.icons.icHostOutline.svg(
                        colorFilter: filter,
                      ),
                    );
                  case PendingInviteType.eventInvite:
                    label = t.home.pendingInvites.eventInvite;
                    leading = ThemeSvgIcon(
                      color: color,
                      builder: (filter) => Assets.icons.icUserAdd.svg(
                        colorFilter: filter,
                      ),
                    );
                    break;
                  case PendingInviteType.friendRequest:
                    label = t.home.pendingInvites.friendRequest;
                    leading = ThemeSvgIcon(
                      color: color,
                      builder: (filter) => Assets.icons.icAddReaction.svg(
                        colorFilter: filter,
                      ),
                    );
                    break;
                }
                return LemonOutlineButton(
                  onTap: () => setState(
                    () => _selectedType = PendingInviteType.values[index],
                  ),
                  label: label,
                  leading: leading,
                  radius: BorderRadius.circular(
                    LemonRadius.button,
                  ),
                  textStyle: Typo.small.copyWith(
                    color: color,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: Sizing.xSmall,
          ),
          if (_selectedType == PendingInviteType.all)
            Expanded(
              child: NotificationListView(
                filter: Input$NotificationTypeFilterInput(
                  $in: [
                    Enum$NotificationType.event_cohost_request,
                    Enum$NotificationType.event_invite,
                    Enum$NotificationType.user_friendship_request,
                  ],
                ),
              ),
            ),
          if (_selectedType == PendingInviteType.cohostRequest)
            Expanded(
              child: NotificationListView(
                filter: Input$NotificationTypeFilterInput(
                  eq: Enum$NotificationType.event_cohost_request,
                ),
              ),
            ),
          if (_selectedType == PendingInviteType.eventInvite)
            Expanded(
              child: NotificationListView(
                filter: Input$NotificationTypeFilterInput(
                  eq: Enum$NotificationType.event_invite,
                ),
              ),
            ),
          if (_selectedType == PendingInviteType.friendRequest)
            Expanded(
              child: NotificationListView(
                filter: Input$NotificationTypeFilterInput(
                  eq: Enum$NotificationType.user_friendship_request,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
