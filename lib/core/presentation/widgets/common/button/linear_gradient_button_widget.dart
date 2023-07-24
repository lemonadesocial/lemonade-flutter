import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

enum GradientButtonMode {
  defaultMode,
  lavenderMode;

  List<Color> get gradients {
    switch (this) {
      case defaultMode:
        return [LemonColor.arsenic, LemonColor.charlestonGreen];
      case lavenderMode:
        return [LemonColor.lavender, LemonColor.grape];
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

  const LinearGradientButton({
    super.key,
    required this.label,
    this.leading,
    this.mode = GradientButtonMode.defaultMode,
    this.onTap,
    this.height,
    this.padding,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? Sizing.medium,
        padding: padding ?? EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.extraSmall),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: mode.gradients,
          ),
          shape: RoundedRectangleBorder(borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall)),
          shadows: [
            BoxShadow(
              color: LemonColor.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, SizedBox(width: Spacing.extraSmall)],
              Text(
                label,
                style: Typo.small.copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
