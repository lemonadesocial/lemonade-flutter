import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? Sizing.medium,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
              vertical: Spacing.extraSmall,
            ),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? colorScheme.outline,
            ),
            borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
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
                      Typo.small.copyWith(
                        color: textColor ?? colorScheme.onSecondary,
                        fontWeight: FontWeight.w600,
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
