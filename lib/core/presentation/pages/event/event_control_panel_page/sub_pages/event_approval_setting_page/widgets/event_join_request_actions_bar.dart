import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventJoinRequestActionsBar extends StatelessWidget {
  final Function()? onPressApprove;
  final Function()? onPressDecline;
  const EventJoinRequestActionsBar({
    super.key,
    this.onPressApprove,
    this.onPressDecline,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        InkWell(
          onTap: onPressApprove,
          child: Container(
            height: Sizing.medium,
            width: Sizing.medium,
            decoration: ShapeDecoration(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizing.medium),
              ),
            ),
            child: Center(
              child: Assets.icons.icDone.svg(
                colorFilter:
                    ColorFilter.mode(LemonColor.paleViolet, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
        InkWell(
          onTap: onPressDecline,
          child: Container(
            height: Sizing.medium,
            width: Sizing.medium,
            decoration: ShapeDecoration(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizing.medium),
              ),
            ),
            child: Center(
              child: Assets.icons.icClose.svg(),
            ),
          ),
        ),
      ],
    );
  }
}
