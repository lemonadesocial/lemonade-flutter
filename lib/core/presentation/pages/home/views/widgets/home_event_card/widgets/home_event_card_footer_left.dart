import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Add this import

class HomeEventCardFooterLeft extends StatelessWidget {
  final Event event;

  const HomeEventCardFooterLeft({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final guestsCount = event.guests;
    final checkInCount = event.checkInCount;
    final pendingRequestsCount = event.pendingRequestCount ?? 0;
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (session) => session.userId,
          orElse: () => '',
        );
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    if (isOwnEvent) {
      return Row(
        children: [
          Row(
            children: [
              ThemeSvgIcon(
                builder: (colorFilter) => Assets.icons.icGuests.svg(
                  width: Sizing.mSmall,
                  height: Sizing.mSmall,
                ),
              ),
              SizedBox(width: Spacing.superExtraSmall),
              Text(
                '$checkInCount/$guestsCount',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: 14.w),
          if (pendingRequestsCount > 0)
            Row(
              children: [
                ThemeSvgIcon(
                  builder: (colorFilter) => Assets.icons.icError.svg(
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  t.event.pendingCount(n: pendingRequestsCount),
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
      );
    }

    if (isAttending) {
      return _buildAttendingLabel(context);
    }

    return const SizedBox.shrink();
  }

  Widget _buildAttendingLabel(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final eventStart = event.start;
    final difference = eventStart?.difference(now) ?? Duration.zero;

    if (EventUtils.isEventLive(event)) {
      return _buildLabel(context, t.event.liveNow, LemonColor.coralReef);
    }

    final formattedTime = _formatTimeUntilEvent(difference);
    return _buildLabel(
      context,
      t.event.startsIn(time: formattedTime),
      colorScheme.onSecondary,
    );
  }

  String _formatTimeUntilEvent(Duration difference) {
    if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'}';
    } else {
      return DateFormat.Hm().format(DateTime.now().add(difference));
    }
  }

  Widget _buildLabel(BuildContext context, String text, Color color) {
    return Text(
      text,
      style: Typo.small.copyWith(
        color: color,
        fontWeight: FontWeight.w500,
        height: 0,
      ),
    );
  }
}
