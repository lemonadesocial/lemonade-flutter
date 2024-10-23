import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class EventConfirmedJoinRequestItem extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final void Function()? onRefetch;

  const EventConfirmedJoinRequestItem({
    super.key,
    required this.eventJoinRequest,
    this.onRefetch,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(
        EventJoinRequestDetailRoute(
          eventJoinRequest: eventJoinRequest,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(
                LemonRadius.extraSmall,
              ),
            ),
            child: Row(
              children: [
                JoinRequestUserAvatar(
                  eventJoinRequest: eventJoinRequest,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
