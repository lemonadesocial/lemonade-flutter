import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return Row(
      children: [
        InkWell(
          onTap: onPressDecline,
          child: Container(
            padding: EdgeInsets.all(Spacing.xSmall),
            decoration: ShapeDecoration(
              color: appColors.cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LemonRadius.small),
              ),
            ),
            child: Center(
              child: Assets.icons.icClose.svg(
                height: Sizing.xSmall,
                width: Sizing.xSmall,
                colorFilter: const ColorFilter.mode(
                  LemonColor.errorRedBg,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
        InkWell(
          onTap: onPressApprove,
          child: Container(
            padding: EdgeInsets.all(Spacing.xSmall),
            decoration: ShapeDecoration(
              color: appColors.cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LemonRadius.small),
              ),
            ),
            child: Row(
              children: [
                Assets.icons.icDone.svg(
                  height: Sizing.xSmall,
                  width: Sizing.xSmall,
                  colorFilter: ColorFilter.mode(
                    LemonColor.paleViolet,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  t.common.actions.accept,
                  style: Typo.small.copyWith(
                    color: appColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
