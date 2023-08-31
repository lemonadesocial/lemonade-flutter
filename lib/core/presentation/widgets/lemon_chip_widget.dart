import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonChip extends StatelessWidget {
  const LemonChip({
    super.key,
    required this.label,
    this.isActive = false,
    this.onTap,
  });
  final String label;
  final bool isActive;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.xSmall,
          vertical: Spacing.extraSmall,
        ),
        height: Sizing.medium,
        constraints: BoxConstraints(minWidth: Sizing.large),
        decoration: BoxDecoration(
            color: isActive ? themeColor.onSurface : themeColor.surface,
            borderRadius: BorderRadius.circular(LemonRadius.normal),),
        child: Center(
          widthFactor: 1,
          heightFactor: 1,
          child: Text(
            label,
            style: Typo.medium.copyWith(
              color: isActive ? themeColor.surface : themeColor.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
