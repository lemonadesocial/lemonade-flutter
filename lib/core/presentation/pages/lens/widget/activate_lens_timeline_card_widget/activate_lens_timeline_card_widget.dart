import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';

class ActivateLensTimelineCardWidget extends StatelessWidget {
  final VoidCallback onActivatePressed;

  const ActivateLensTimelineCardWidget({
    super.key,
    required this.onActivatePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      margin: EdgeInsets.only(
        top: Spacing.medium,
        right: Spacing.small,
        bottom: Spacing.small,
        left: Spacing.small,
      ),
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.white06,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: Sizing.medium,
                height: Sizing.medium,
                padding: EdgeInsets.all(Spacing.extraSmall),
                decoration: BoxDecoration(
                  color: LemonColor.white06,
                  border: Border.all(
                    color: LemonColor.white03,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                ),
                child: ThemeSvgIcon(
                  builder: (colorFilter) => Assets.icons.icNewspaper.svg(
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.small),
          Text(
            t.lens.activateTimeline,
            style: Typo.large.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            t.lens.activateTimelineDescription,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(height: Spacing.small),
          LinearGradientButton.whiteButton(
            onTap: onActivatePressed,
            label: t.lens.activate,
          ),
        ],
      ),
    );
  }
}
