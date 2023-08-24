import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonFilledButton extends StatelessWidget {
  const LemonFilledButton({
    super.key,
    this.label,
    this.leading,
    this.onTap,
    this.padding,
    this.height,
    this.radius,
    this.color,
    this.textColor,
  });
  final String? label;
  final Widget? leading;
  final Function()? onTap;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? Sizing.medium,
        padding: padding ?? EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.extraSmall),
        decoration: ShapeDecoration(
          color: color ?? colorScheme.onPrimary.withOpacity(0.87),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: color ?? colorScheme.onPrimary.withOpacity(0.87),
            ),
            borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                if (label != null) SizedBox(width: Spacing.extraSmall),
              ],
              if (label != null)
                Text(
                  label!,
                  style: Typo.small.copyWith(
                    color: textColor ?? colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
