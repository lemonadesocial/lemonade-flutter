import 'package:app/core/application/event_tickets/generate_event_invitation_url_bloc/generate_event_invitation_url_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static shareEvent(BuildContext context, Event event) {
    final userId = AuthUtils.getUser(context)?.userId ?? '';
    final isCohost = EventUtils.isCohost(
      event: event,
      userId: userId,
    );
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);

    // Use shortid if is own event or cohost
    if (isOwnEvent || isCohost) {
      return Share.shareUri(
        Uri.parse('${AppConfig.webUrl}/e/${event.shortId}'),
      );
    }
    // Special case for attending, use invitation url instead of shortid
    if (isAttending) {
      final invitationUrl =
          context.read<GenerateEventInvitationUrlBloc>().state.whenOrNull(
                success: (invitationUrl) => invitationUrl,
              );
      return Share.shareUri(
        Uri.parse(invitationUrl ?? ''),
      );
    }
  }
}
