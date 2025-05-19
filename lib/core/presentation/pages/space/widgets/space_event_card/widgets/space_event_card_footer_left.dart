import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/space/widgets/space_event_card/widgets/space_event_card_price_info.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

class SpaceEventCardFooterLeft extends StatelessWidget {
  final Event event;

  const SpaceEventCardFooterLeft({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (event.published != true) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.s0_5,
                    horizontal: Spacing.s1_5,
                  ),
                  decoration: BoxDecoration(
                    color: appColors.buttonWarningBg,
                    borderRadius: BorderRadius.circular(LemonRadius.xs),
                  ),
                  child: Text(
                    t.common.draft,
                    style: appText.sm.copyWith(
                      color: appColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.s1_5),
              ],
              ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (colorFilter) => Assets.icons.icGuests.svg(
                  width: Sizing.s4,
                  height: Sizing.s4,
                  colorFilter: colorFilter,
                ),
              ),
              SizedBox(width: Spacing.s1_5),
              Text(
                '$checkInCount/$registrationCount',
                style: appText.sm.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(width: Spacing.s3),
          if (pendingRequestsCount > 0)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  color: appColors.textError,
                  builder: (colorFilter) => Assets.icons.icError.svg(
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                    colorFilter: colorFilter,
                  ),
                ),
                SizedBox(width: Spacing.s1_5),
                Text(
                  t.event.pendingCount(n: pendingRequestsCount),
                  style: appText.sm.copyWith(
                    color: appColors.textSecondary,
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

    return SpaceEventCardPriceInfo(event: event);
  }

  Widget _buildAttendingLabel(BuildContext context) {
    final now = DateTime.now();
    final eventStart = event.start;
    final difference = eventStart?.difference(now) ?? Duration.zero;
    final appColors = context.theme.appColors;

    if (EventUtils.isEventLive(event)) {
      return _buildLabel(context, t.event.liveNow, appColors.textError);
    }

    final formattedTime = _formatTimeUntilEvent(difference);
    return _buildLabel(
      context,
      t.event.startingInTime(time: formattedTime),
      appColors.textSecondary,
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
    final appText = context.theme.appTextTheme;
    return Text(
      text,
      style: appText.sm.copyWith(
        color: color,
      ),
    );
  }
}
