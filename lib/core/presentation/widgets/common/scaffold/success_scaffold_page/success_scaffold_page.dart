import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScaffoldPage extends StatelessWidget {
  const SuccessScaffoldPage({
    super.key,
    required this.title,
    required this.description,
    this.buttonBuilder,
    this.buttonLabel,
    this.onPressed,
  });

  final String title;
  final String description;
  final Widget Function(BuildContext context)? buttonBuilder;
  final String? buttonLabel;
  final Function(BuildContext context)? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SuccessCircle(),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
                      child: Text(
                        title,
                        style: Typo.extraLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                      child: Text(
                        description,
                        style: Typo.mediumPlus.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: Spacing.xLarge),
                    buttonBuilder != null
                        ? buttonBuilder!.call(context)
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Spacing.small),
                            child: LinearGradientButton.primaryButton(
                              onTap: () => onPressed?.call(context),
                              label: buttonLabel ?? '',
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessCircle extends StatelessWidget {
  const _SuccessCircle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450.w,
      height: 450.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) => Transform.scale(
                scale: 1.5,
                child: RippleAnimation(
                  size: constraints.maxWidth,
                  color: const Color.fromRGBO(12, 20, 17, 1),
                  scaleTween: Tween<double>(begin: 0.3, end: 1),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [
                    Colors.black,
                    Color.fromRGBO(12, 20, 17, 1),
                  ],
                  stops: [
                    0.5,
                    1,
                  ],
                ),
                borderRadius: BorderRadius.circular(240.w),
              ),
              width: 240.w,
              height: 240.w,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Assets.icons.icSuccess.svg(),
          ),
        ],
      ),
    );
  }
}
