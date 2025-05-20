import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/widgets/home_event_card_price_info.dart';
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

class HomeEventCardFooterLeft extends StatelessWidget {
  final Event event;

  const HomeEventCardFooterLeft({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final checkInCount = event.checkInCount ?? 0;
    final registrationCount = event.ticketCount ?? 0;
    final pendingRequestsCount = event.pendingRequestCount ?? 0;

    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (session) => session.userId,
          orElse: () => '',
        );
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);
    final isCohost = EventUtils.isCohost(event: event, userId: userId);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    if (isOwnEvent || isCohost) {
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
                '$checkInCount/$registrationCount',
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

    return HomeEventCardPriceInfo(event: event);
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
      t.event.startingInTime(time: formattedTime),
      colorScheme.onSecondary,
    );
  }

  String _formatTimeUntilEvent(Duration difference) {
    final absoluteDifference = difference.abs();
    if (absoluteDifference.inDays >= 7) {
      final weeks = (absoluteDifference.inDays / 7).floor();
      return t.common.week(n: weeks);
    } else if (absoluteDifference.inDays > 0) {
      return t.common.day(n: absoluteDifference.inDays);
    } else {
      final hours = absoluteDifference.inHours;
      final minutes = absoluteDifference.inMinutes.remainder(60);
      return '${hours}h ${minutes}m';
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
