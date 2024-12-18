import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventJoinRequestStatusHistoryStep extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subTitle;
  final Widget? more;
  const EventJoinRequestStatusHistoryStep({
    super.key,
    required this.leading,
    required this.title,
    required this.subTitle,
    this.more,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        leading,
        SizedBox(width: Spacing.xSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        const Spacer(),
        if (more != null) more!,
      ],
    );
  }
}

enum EventJoinRequestHistoryStatus {
  pending,
  done,
  rejected,
}

class EventJoinrequestStatusHistoryIcon extends StatelessWidget {
  final EventJoinRequestHistoryStatus status;
  const EventJoinrequestStatusHistoryIcon({
    super.key,
    required this.status,
  });

  Widget getIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (status == EventJoinRequestHistoryStatus.pending) {
      return Container(
        height: 9.w,
        width: 9.w,
        decoration: ShapeDecoration(
          color: colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LemonRadius.xSmall),
          ),
        ),
      );
    }

    if (status == EventJoinRequestHistoryStatus.done) {
      return ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (filter) => Assets.icons.icDone.svg(
          width: Sizing.xSmall,
          height: Sizing.xSmall,
          colorFilter: filter,
        ),
      );
    }

    if (status == EventJoinRequestHistoryStatus.rejected) {
      return ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (filter) => Assets.icons.icClose.svg(
          width: Sizing.xSmall,
          height: Sizing.xSmall,
          colorFilter: filter,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizing.medium,
      width: Sizing.medium,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizing.medium),
        color: status == EventJoinRequestHistoryStatus.pending
            ? LemonColor.atomicBlack
            : LemonColor.darkBackground,
        border: Border.all(
          color: status == EventJoinRequestHistoryStatus.pending
              ? LemonColor.darkBackground
              : Colors.transparent,
          width: 2.w,
        ),
      ),
      child: Center(
        child: getIcon(context),
      ),
    );
  }
}
