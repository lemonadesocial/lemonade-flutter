import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_ticket_info.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
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
    return Column(
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
                user: eventJoinRequest.userExpanded,
              ),
              const Spacer(),
              EventJoinRequestTicketInfo(
                eventJoinRequest: eventJoinRequest,
                showPrice: false,
                backgroundColor: colorScheme.onPrimary.withOpacity(0.06),
                borderColor: Colors.transparent,
                radius: LemonRadius.button,
                textStyle: Typo.small.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
