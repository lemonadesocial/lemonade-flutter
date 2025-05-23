import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

class LemonOutlineButton extends StatelessWidget {
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onTap;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const LemonOutlineButton({
    super.key,
    this.label,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding,
    this.height,
    this.radius,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? Sizing.s9,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: Spacing.s2_5,
            ),
        decoration: ShapeDecoration(
          color: backgroundColor ?? Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? appColors.pageDivider,
            ),
            borderRadius: radius ?? BorderRadius.circular(LemonRadius.sm),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                if (label != null) SizedBox(width: Spacing.extraSmall),
              ],
              if (label != null)
                Text(
                  label!,
                  style: textStyle ??
                      appText.sm.copyWith(
                        color: textColor ?? appColors.textSecondary,
                      ),
                ),
              if (trailing != null) ...[
                if (trailing != null) SizedBox(width: Spacing.extraSmall),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
