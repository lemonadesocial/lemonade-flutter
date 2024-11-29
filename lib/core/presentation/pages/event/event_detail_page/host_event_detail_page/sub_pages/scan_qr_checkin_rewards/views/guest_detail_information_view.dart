import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class GuestDetailInformationView extends StatelessWidget {
  const GuestDetailInformationView({
    super.key,
    required this.ticket,
  });

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final assignedEmail = ticket.assignedEmail;
    final assignedToExpanded = ticket.assignedToExpanded;
    final displayEmail = assignedEmail ?? assignedToExpanded?.email;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LemonCircleAvatar(
          size: Sizing.xLarge,
          url: AvatarUtils.getAvatarUrl(user: assignedToExpanded),
        ),
        SizedBox(height: Spacing.small),
        if (assignedToExpanded?.name != null)
          Text(
            assignedToExpanded?.name ?? '',
            style: Typo.large.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onPrimary,
            ),
          ),
        if (displayEmail != null)
          Text(
            displayEmail,
            style: Typo.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: colorScheme.onSecondary,
            ),
          ),
      ],
    );
  }
}
