import 'package:app/core/presentation/widgets/animation/success_circle_animation_widget.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceAmbassadorUnlockedBottomsheet extends StatelessWidget {
  const SpaceAmbassadorUnlockedBottomsheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: LemonColor.atomicBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: BottomSheetGrabber(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SuccessCircleAnimationWidget(),
                Text(
                  t.space.ambassadorUnlocked,
                  style: Typo.large.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  t.space.ambassadorUnlockedDescription,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                SafeArea(
                  child: LinearGradientButton.secondaryButton(
                    label: t.space.viewCommunity,
                    mode: GradientButtonMode.light,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
