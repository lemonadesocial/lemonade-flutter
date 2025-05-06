import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateLensAccountSuccessBottomSheet extends StatelessWidget {
  const CreateLensAccountSuccessBottomSheet({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          SizedBox(height: Spacing.xSmall),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Sizing.large,
                  height: Sizing.large,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LemonColor.malachiteGreen.withOpacity(0.18),
                  ),
                  child: Center(
                    child: ThemeSvgIcon(
                      color: LemonColor.malachiteGreen,
                      builder: (filter) => Assets.icons.icDone.svg(
                        colorFilter: filter,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Spacing.small),
                Text(
                  "Username claimed",
                  style: Typo.extraLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: Spacing.extraSmall),
                Text(
                  "You’ve secured your Lemonade username. You can now start posting, interacting, and showing up on the timeline.",
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                Container(
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    color: LemonColor.paleViolet18,
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "@",
                        style: Typo.medium.copyWith(
                          color: LemonColor.paleViolet,
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                      Text(
                        username,
                        style: Typo.medium.copyWith(
                          color: LemonColor.paleViolet,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Spacing.medium),
                LinearGradientButton.secondaryButton(
                  mode: GradientButtonMode.light,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  label: t.common.done,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
