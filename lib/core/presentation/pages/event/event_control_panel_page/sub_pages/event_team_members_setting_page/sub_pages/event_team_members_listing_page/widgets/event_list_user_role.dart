import 'dart:convert';

import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_listing_page/widgets/event_team_members_item_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventListUserRole extends StatelessWidget {
  const EventListUserRole({
    super.key,
    required this.eventId,
    required this.selectedFilterRole,
    required this.eventUserRoles,
  });
  final String eventId;
  final EventRole? selectedFilterRole;
  final List<EventUserRole>? eventUserRoles;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: Spacing.small,
          right: Spacing.small,
          bottom: Spacing.xLarge,
        ),
        child: ListView.separated(
          itemCount: eventUserRoles?.length ?? 0,
          itemBuilder: (context, index) {
            final item = eventUserRoles?[index];
            final email = item?.email ?? '';
            final isInvitedViaEmail = item?.user == null;
            final user = item?.user;
            final name = item?.user?.name ?? '';
            final username = item?.user?.username ?? '';
            final isFirst = index == 0;
            final isLast = index == ((eventUserRoles ?? []).length - 1);
            final roleName = item?.roles?.first.roleExpanded?.name ?? '';
            return EventTeamMemberItemWidget(
              title: isInvitedViaEmail ? email : name,
              subTitle: isInvitedViaEmail
                  ? t.event.teamMembers.invitedViaEmail
                  : username,
              onTap: () {},
              isFirst: isFirst,
              isLast: isLast,
              roleName: roleName,
              user: user,
            );
          },
          separatorBuilder: (context, index) =>
              SizedBox(height: Spacing.xSmall),
        ),
      ),
    );
  }
}
