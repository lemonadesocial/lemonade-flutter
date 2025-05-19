import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

class SpaceEventCardFooterRight extends StatelessWidget {
  final Event event;
  const SpaceEventCardFooterRight({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (session) => session.userId,
          orElse: () => '',
        );
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);
    final isCohost = EventUtils.isCohost(event: event, userId: userId);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    var label = t.event.register;
    if (isOwnEvent || isCohost) {
      label = t.event.manage;
    } else if (isAttending) {
      label = t.common.actions.viewTicket;
    }
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.s0_5,
        horizontal: Spacing.s1_5,
      ),
      decoration: BoxDecoration(
        color: appColors.chipSecondaryBg,
        borderRadius: BorderRadius.circular(LemonRadius.xs),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: appText.sm.copyWith(
              color: appColors.chipSecondary,
            ),
          ),
          SizedBox(width: Spacing.s1_5),
          ThemeSvgIcon(
            color: appColors.chipSecondary,
            builder: (filter) => Assets.icons.icArrowRight.svg(
              width: Sizing.s4,
              height: Sizing.s4,
              colorFilter: filter,
            ),
          ),
        ],
      ),
    );
  }
}
