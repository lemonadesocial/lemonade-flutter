import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
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
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.normal),
                topRight: Radius.circular(LemonRadius.normal),
                bottomLeft: Radius.circular(LemonRadius.xSmall),
                bottomRight: Radius.circular(LemonRadius.xSmall),
              ),
            ),
            child: _RowInfo(
              title: t.event.rsvpStatus.approvalRequired,
              subTitle: t.event.rsvpStatus.fromCohostToJoin,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icOutlineVerified.svg(
                  colorFilter: colorFilter,
                ),
              ),
            ),
          ),
        if (event.guestLimit != null) ...[
          SizedBox(height: Spacing.superExtraSmall),
          Container(
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.xSmall),
                topRight: Radius.circular(LemonRadius.xSmall),
                bottomLeft: Radius.circular(LemonRadius.normal),
                bottomRight: Radius.circular(LemonRadius.normal),
              ),
            ),
            child: _RowInfo(
              title: t.event.rsvpStatus.limitedSpots,
              subTitle: t.event.rsvpStatus.registerBeforeEventFillsUp,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icClockBurning.svg(
                  colorFilter: colorFilter,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: Sizing.medium,
          height: Sizing.medium,
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.circular(Sizing.medium),
          ),
          child: Center(
            child: icon,
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Typo.small.copyWith(
                color: colorScheme.onPrimary,
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
