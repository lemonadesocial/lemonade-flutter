import 'package:app/theme/color.dart';
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
        return [LemonColor.button_linear_1, LemonColor.button_linear_2];
      default:
        return [];
    }
  }

  Color? get disableColor {
    switch (this) {
      case lavenderMode:
        return LemonColor.disableButtonLavender;
      default:
        return null;
    }
  }
}

class LinearGradientButton extends StatelessWidget {
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
  });

  final GradientButtonMode mode;
  final String label;
  final Widget? leading;
  final Function()? onTap;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
        decoration: BoxDecoration(
          borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: mode.gradients,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
            boxShadow: [
              BoxShadow(
                blurRadius: 48.r,
              ),
              BoxShadow(
                color: LemonColor.black.withOpacity(0.36),
                offset: const Offset(0, 2),
                blurRadius: 15.r,
              ),
            ],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style:
                textStyle ?? Typo.medium.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
