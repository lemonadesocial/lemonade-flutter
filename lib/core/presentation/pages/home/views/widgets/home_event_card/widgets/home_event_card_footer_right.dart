import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeEventCardFooterRight extends StatelessWidget {
  final Event event;
  const HomeEventCardFooterRight({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (session) => session.userId,
          orElse: () => '',
        );
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);
    final isCohost = EventUtils.isCohost(event: event, userId: userId);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    final colorScheme = Theme.of(context).colorScheme;
    var label = t.event.register;
    if (isOwnEvent || isCohost) {
      label = t.event.manage;
    } else if (isAttending) {
      label = t.common.actions.viewTicket;
    }
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
        decoration: ShapeDecoration(
          color: LemonColor.white09,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              LemonRadius.small / 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
                height: 0,
              ),
            ),
            const SizedBox(width: 6),
            ThemeSvgIcon(
              color: colorScheme.onSurfaceVariant,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                width: 15.w,
                height: 15.w,
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
