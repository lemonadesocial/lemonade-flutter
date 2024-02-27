import 'package:app/theme/typo.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class LemonChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final Function()? onTap;
  final Color? activeBackgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? borderColor;
  final Widget? icon;
  const LemonChip({
    super.key,
    required this.label,
    this.isActive = false,
    this.onTap,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.small,
          vertical: Spacing.extraSmall,
        ),
        constraints: BoxConstraints(minWidth: Sizing.large),
        decoration: BoxDecoration(
          color: isActive
              ? activeBackgroundColor ?? themeColor.onSurface
              : inactiveBackgroundColor ?? themeColor.surface,
          borderRadius: BorderRadius.circular(LemonRadius.normal),
          border:
              Border.all(color: borderColor ?? Colors.transparent, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Padding(
                padding: EdgeInsets.only(right: Spacing.superExtraSmall),
                child: icon,
              ),
            ],
            Text(
              label,
              style: Typo.medium.copyWith(
                color: isActive
                    ? activeTextColor ?? themeColor.surface
                    : inactiveTextColor ?? themeColor.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
