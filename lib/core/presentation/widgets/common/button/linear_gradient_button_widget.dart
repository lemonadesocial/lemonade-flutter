import 'package:app/core/presentation/widgets/lemon_inner_shadow.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum GradientButtonMode {
  defaultMode,
  lavenderMode;

  List<Color> get gradients {
    switch (this) {
      case defaultMode:
        return [LemonColor.arsenic, LemonColor.charlestonGreen];
      case lavenderMode:
        return [LemonColor.buttonLinear1, LemonColor.buttonLinear2];
      default:
        return [];
    }
  }
}

class LinearGradientButton extends StatelessWidget {
  final GradientButtonMode mode;
  final String label;
  final Widget? leading;
  final Function()? onTap;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final TextStyle? textStyle;
  final Offset? shadowOffset;

  const LinearGradientButton({
    super.key,
    required this.label,
    this.leading,
    this.mode = GradientButtonMode.defaultMode,
    this.onTap,
    this.height,
    this.padding,
    this.radius,
    this.textStyle,
    this.shadowOffset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
        child: InnerShadow(
          color: Colors.white.withOpacity(0.36),
          offset: shadowOffset ?? const Offset(0, 4),
          blur: 4,
          child: Container(
            height: height ?? Sizing.medium,
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
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: Spacing.extraSmall)
                ],
                Text(
                  label,
                  style: textStyle ??
                      Typo.small.copyWith(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
