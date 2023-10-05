import 'dart:math';

import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapBusyPopup extends StatelessWidget {
  final String title;
  const PoapBusyPopup({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      backgroundColor: LemonColor.atomicBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        width: 200.w,
        padding: EdgeInsets.all(Spacing.medium),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AnimatedClock(),
                    SizedBox(width: Spacing.xSmall),
                    Text(
                      StringUtils.capitalize(title),
                      style: Typo.large.copyWith(
                        color: colorScheme.onPrimary,
                        fontFamily: FontFamily.switzerVariable,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Spacing.extraSmall),
                Text(
                  t.nft.waitingForConfirmation,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontFamily: FontFamily.switzerVariable,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Spacing.small),
                LinearGradientButton(
                  onTap: () => Navigator.of(context).pop(),
                  label: t.common.actions.dismiss,
                  mode: GradientButtonMode.lavenderMode,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedClock extends StatefulWidget {
  const AnimatedClock({super.key});

  @override
  State<AnimatedClock> createState() => _AnimatedClockState();
}

class _AnimatedClockState extends State<AnimatedClock>
    with SingleTickerProviderStateMixin {
  late final animationCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..repeat(reverse: true);

  late Animation<double> rotateAnimation =
      Tween(begin: 0.0, end: pi).animate(animationCtrl);

  @override
  void dispose() {
    animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotateAnimation,
      builder: (context, child) => Transform.rotate(
        angle: rotateAnimation.value,
        child: child,
      ),
      child: Text('⏳', style: Typo.extraLarge),
    );
  }
}
