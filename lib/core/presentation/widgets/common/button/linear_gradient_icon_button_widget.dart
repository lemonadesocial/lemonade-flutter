import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_inner_shadow.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinearGradientIconButton extends StatelessWidget {
  final GradientButtonMode mode;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final TextStyle? textStyle;
  final Offset? shadowOffset;
  final Widget? icon;

  const LinearGradientIconButton({
    super.key,
    this.mode = GradientButtonMode.defaultMode,
    this.onTap,
    this.height,
    this.width,
    this.padding,
    this.radius,
    this.textStyle,
    this.shadowOffset,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
        child: InnerShadow(
          color: Colors.white.withOpacity(0.06),
          offset: shadowOffset ?? const Offset(0, 4),
          blur: 4,
          child: _childButton,
        ),
      ),
    );
  }

  Widget get _childButton => Container(
        height: height ?? Sizing.medium,
        width: width,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
              vertical: Spacing.extraSmall,
            ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: mode.gradients,
          ),
          boxShadow: [
            BoxShadow(
              color: LemonColor.black.withOpacity(0.30),
              offset: const Offset(0, 2),
              blurRadius: 18.r,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: icon,
        ),
      );
}
