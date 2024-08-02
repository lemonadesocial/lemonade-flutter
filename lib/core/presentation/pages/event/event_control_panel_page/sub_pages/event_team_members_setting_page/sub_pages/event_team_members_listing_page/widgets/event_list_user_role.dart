import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/widgets/event_team_members_item_widget.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventListUserRole extends StatelessWidget {
  const EventListUserRole(
      {super.key, required this.eventId, required this.selectedFilterRole});
  final String eventId;
  final EventRole? selectedFilterRole;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<EventRepository>()
          .getListUserRole(eventId: eventId, roleId: selectedFilterRole?.id),
      builder: (context, snapshot) {
        final listUserRole =
            snapshot.data?.fold((l) => null, (listUserRole) => listUserRole);
        return SliverPadding(
          padding: EdgeInsets.only(
            left: Spacing.small,
            right: Spacing.small,
            bottom: Spacing.xLarge,
          ),
          sliver: SliverList.separated(
            itemCount: listUserRole?.length ?? 0,
            itemBuilder: (context, index) {
              final item = listUserRole?[index];
              final name = item?.user?.name ?? '';
              final username = item?.user?.username ?? '';
              final isFirst = index == 0;
              final isLast = index == 9;
              return EventTeamMemberItemWidget(
                title: name,
                subTitle: username,
                onTap: () {},
                isFirst: isFirst,
                isLast: isLast,
              );
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.xSmall),
          ),
        );
      },
    );
  }
}
