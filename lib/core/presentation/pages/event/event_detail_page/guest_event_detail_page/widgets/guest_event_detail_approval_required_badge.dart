import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailApprovalRequiredBadge extends StatelessWidget {
  final Event event;
  const GuestEventDetailApprovalRequiredBadge({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (event.approvalRequired == true)
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
              border: Border.all(
                color: colorScheme.outlineVariant,
                width: 1.w,
              ),
            ),
            child: _RowInfo(
              title: t.event.rsvpStatus.approvalRequired,
              subTitle: t.event.rsvpStatus.fromCohostToJoin,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icOutlineVerified.svg(
                  colorFilter: colorFilter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
          ),
        if (event.guestLimit != null) ...[
          SizedBox(height: Spacing.xSmall),
          Container(
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
              border: Border.all(
                color: colorScheme.outlineVariant,
                width: 1.w,
              ),
            ),
            child: _RowInfo(
              title: t.event.rsvpStatus.limitedSpots,
              subTitle: t.event.rsvpStatus.registerBeforeEventFillsUp,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icClockBurning.svg(
                  colorFilter: colorFilter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RowInfo extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  const _RowInfo({
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: Spacing.xSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.w),
            Text(
              subTitle,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
