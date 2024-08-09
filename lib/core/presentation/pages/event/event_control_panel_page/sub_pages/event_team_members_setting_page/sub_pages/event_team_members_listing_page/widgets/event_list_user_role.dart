import 'package:app/core/application/event/event_team_members_form_bloc/event_team_members_form_bloc.dart';
import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_listing_page/widgets/event_edit_team_member_bottomsheet.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_listing_page/widgets/event_team_members_item_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EventListUserRole extends StatelessWidget {
  const EventListUserRole({
    super.key,
    required this.eventId,
    required this.selectedFilterRole,
    required this.eventUserRoles,
    this.refetch,
  });
  final String eventId;
  final EventRole? selectedFilterRole;
  final List<EventUserRole>? eventUserRoles;
  final Function()? refetch;

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
              onTap: () {
                context.read<EventTeamMembersFormBloc>().add(
                      EventTeamMembersFormBlocEvent.selectRole(
                        role: item?.roles?.first.roleExpanded,
                      ),
                    );
                showCupertinoModalBottomSheet(
                  context: context,
                  backgroundColor: LemonColor.atomicBlack,
                  topRadius: Radius.circular(30.r),
                  barrierColor: Colors.black.withOpacity(0.8),
                  builder: (mContext) {
                    return EventEditTeamMemberBottomSheet(
                      eventUserRole: item,
                      refetch: refetch,
                    );
                  },
                );
              },
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
